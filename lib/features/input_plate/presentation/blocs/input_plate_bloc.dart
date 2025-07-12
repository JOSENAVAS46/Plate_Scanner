import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:plate_scanner_app/core/cache/database/crud_database/crud_history.dart';
import 'package:plate_scanner_app/core/enums/enum.dart';
import 'package:plate_scanner_app/core/errors/error_responses_methods.dart';
import 'package:plate_scanner_app/core/services/location_service.dart';
import 'package:plate_scanner_app/core/utils/methods.dart';
import 'package:plate_scanner_app/features/_other/data/models/aux_history_converter_model.dart';
import 'package:plate_scanner_app/features/_other/data/models/form_status.dart';
import 'package:plate_scanner_app/features/_other/data/models/res_detect_input_model.dart';
import 'package:plate_scanner_app/features/input_plate/data/models/req_input_plate_model.dart';
import 'package:plate_scanner_app/features/input_plate/data/repositories/input_plate_repository.dart';

part 'input_plate_event.dart';
part 'input_plate_state.dart';

class InputPlateBloc extends Bloc<InputPlateEvent, InputPlateState> {
  final InputPlateRepository repository;
  final CrudHistory crudHistory = CrudHistory();

  InputPlateBloc({required this.repository}) : super(InputPlateState()) {
    on<SendInputPlateEvent>(_onSendInputPlateEvent);
  }

  Future<void> _onSendInputPlateEvent(
      SendInputPlateEvent event, Emitter<InputPlateState> emit) async {
    emit(
        state.copyWith(formStatus: LoadingState(mensaje: 'Enviando placa...')));
    try {
      if (event.plate.isEmpty) {
        emit(state.copyWith(
          formStatus: MessageState(
            mensaje: 'La placa no puede estar vacía',
            tipo: TipoMensajeBloc.error,
          ),
        ));
        return;
      }
      var device = await getDeviceInfo();
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
      var usuario = new UsuarioReqInputPlateModel(
        deviceId: device.deviceId,
        deviceName: device.deviceName,
        deviceModel: device.deviceModel,
        deviceBrand: device.deviceBrand,
        serialNumber: device.serialNumber,
        activo: device.activo,
        creadoEn: device.creadoEn,
      );

      // 2. Preparar el modelo de solicitud
      final reqInputPlateModel = ReqInputPlateModel(
        usuario: usuario,
        placa: event.plate,
        latitud: coordinates.latitude,
        longitud: coordinates.longitude,
      );

      // 3. Enviar la solicitud al repositorio
      final response = await repository.enviarInputPlaca(
          reqInputPlateModel: reqInputPlateModel);

      // 4. Manejar la respuesta
      if (response.status) {
        if (response.data!.data != null) {
          var auxHistory = AuxHistoryConverterModel(
            tipo: 'M',
            objeto: jsonEncode(response.data!.data),
            base64Img: null,
          );
          crudHistory.insert(auxHistory);
          emit(state.copyWith(
            formStatus: VehiculoRecibidoState(response: response.data!),
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
