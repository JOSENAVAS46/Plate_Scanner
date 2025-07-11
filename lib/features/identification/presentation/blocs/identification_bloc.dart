import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:plate_scanner_app/core/enums/enum.dart';
import 'package:plate_scanner_app/core/errors/error_responses_methods.dart';
import 'package:plate_scanner_app/core/services/location_service.dart';
import 'package:plate_scanner_app/core/utils/methods.dart';
import 'package:plate_scanner_app/features/_other/data/models/form_status.dart';
import 'package:plate_scanner_app/features/identification/data/models/req_detect_model.dart';
import 'package:plate_scanner_app/features/_other/data/models/res_detect_input_model.dart';
import 'package:plate_scanner_app/features/identification/data/repositories/identification_repository.dart';

part 'identification_event.dart';
part 'identification_state.dart';

class IdentificationBloc
    extends Bloc<IdentificationEvent, IdentificationState> {
  final IdentificationRepository repository;

  IdentificationBloc({required this.repository})
      : super(IdentificationState()) {
    on<SendImgBytesEvent>(_onSendImgBytesEvent);
  }

  Future<void> _onSendImgBytesEvent(
      SendImgBytesEvent event, Emitter<IdentificationState> emit) async {
    // Estado inicial de carga
    emit(state.copyWith(
        formStatus: LoadingState(mensaje: 'Procesando imagen...')));

    try {
      var device = await getDeviceInfo();

      // 1. Validar y leer la imagen
      final imageFile = File(event.imagePath);
      if (!await imageFile.exists()) {
        emit(state.copyWith(
          formStatus: MessageState(
            mensaje: 'La imagen no existe en la ruta proporcionada',
            tipo: TipoMensajeBloc.error,
          ),
        ));
        return;
      }

      // 2. Convertir a base64 (de forma asíncrona)
      final bytes = await imageFile.readAsBytes();
      final base64Image = base64Encode(bytes);

      // 3. Obtener ubicación (paralelamente si es posible)
      final coordinates = await LocationService.getCoordinates();
      if (coordinates == null) {
        emit(state.copyWith(
          formStatus: MessageState(
            mensaje: 'No se pudo obtener la ubicación',
            tipo: TipoMensajeBloc.error,
          ),
        ));
        return;
      }
      var usuario = new UsuarioReqDetectModel(
        deviceId: device.deviceId,
        deviceName: device.deviceName,
        deviceModel: device.deviceModel,
        deviceBrand: device.deviceBrand,
        serialNumber: device.serialNumber,
        activo: device.activo,
        creadoEn: device.creadoEn,
      );
      // 4. Preparar modelo de solicitud
      final reqDetectModel = ReqDetectModel(
        usuario: usuario,
        image: base64Image,
        latitud: coordinates.latitude,
        longitud: coordinates.longitude,
      );

      // 5. Enviar al repositorio
      final response = await repository.enviarImagenEnBytes(
        reqDetectModel: reqDetectModel,
      );
      if (response.status) {
        if (response.data!.data != null) {
          emit(state.copyWith(
            formStatus: DeteccionRecibidaState(response: response.data!),
          ));
        } else {
          emit(state.copyWith(
            formStatus: MessageState(
              mensaje: response.data!.message ?? 'Error al enviar la placa',
              tipo: TipoMensajeBloc.error,
            ),
          ));
        }
      } else {
        emit(state.copyWith(
          formStatus: MessageState(
            mensaje: response.mensaje,
            tipo: TipoMensajeBloc.error,
          ),
        ));
      }
    } on Exception catch (e) {
      // Manejo centralizado de errores
      emit(state.copyWith(
        formStatus: MessageState(
          mensaje: getErrorMessage(e),
          tipo: TipoMensajeBloc.error,
        ),
      ));
    } finally {
      emit(state.copyWith(formStatus: InitialState()));
    }
  }
}
