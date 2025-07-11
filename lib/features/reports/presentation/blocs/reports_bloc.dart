import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:plate_scanner_app/core/enums/enum.dart';
import 'package:plate_scanner_app/core/errors/error_responses_methods.dart';
import 'package:plate_scanner_app/core/utils/methods.dart';
import 'package:plate_scanner_app/features/_other/data/models/form_status.dart';
import 'package:plate_scanner_app/features/identification/data/models/req_detect_model.dart';
import 'package:plate_scanner_app/features/reports/data/models/req_consulta_model.dart';
import 'package:plate_scanner_app/features/reports/data/models/req_report_model.dart';
import 'package:plate_scanner_app/features/reports/data/models/res_consulta_model.dart';
import 'package:plate_scanner_app/features/reports/data/models/res_report_data_model.dart';
import 'package:plate_scanner_app/features/reports/data/models/res_report_pdf_model.dart';
import 'package:plate_scanner_app/features/reports/data/models/vehiculo_csv_model.dart';
import 'package:plate_scanner_app/features/reports/data/repositories/reports_repository.dart';

part 'reports_event.dart';
part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  final ReportsRepository repository;

  ReportsBloc({required this.repository}) : super(ReportsState()) {
    on<GetVehiculosCSVEvent>(_onGetVehiculosCSV);
    on<GetConsultasByUserEvent>(_onGetConsultasByUser);
    on<GetPdfReportEvent>(_onGetPdfReport);
    on<GetDataReportEvent>(_onGetDataReport);
  }

  Future<void> _onGetConsultasByUser(
      GetConsultasByUserEvent event, Emitter<ReportsState> emit) async {
    emit(state.copyWith(formStatus: LoadingState(mensaje: 'Cargando...')));
    try {
      var device = await getDeviceInfo();
      var reqConsultaModel = new ReqConsultaModel(
        deviceId: device.deviceId,
        deviceName: device.deviceName,
        deviceModel: device.deviceModel,
        deviceBrand: device.deviceBrand,
        serialNumber: device.serialNumber,
        activo: device.activo,
        creadoEn: device.creadoEn,
      );
      final response = await repository.obtenerConsultabyUser(
          reqConsultaModel: reqConsultaModel);
      if (response.status) {
        if (response.data!.data != null) {
          emit(state.copyWith(
            formStatus: RecibirConsultaState(response: response.data!),
          ));
        } else {
          emit(state.copyWith(
            formStatus: MessageState(
              mensaje: response.data!.message ?? 'Error al obtener datos',
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
    }
  }

  Future<void> _onGetVehiculosCSV(
      GetVehiculosCSVEvent event, Emitter<ReportsState> emit) async {
    emit(state.copyWith(formStatus: LoadingState(mensaje: 'Cargando...')));

    final response = await repository.obtenerListaCsv();

    if (response.status) {
      emit(ReportsState(
        formStatus: ListaVehiculosCSVLoadedState(vehiculos: response.data!),
      ));
    } else {
      emit(ReportsState(
        formStatus: MessageState(
          mensaje: response.mensaje,
          tipo: TipoMensajeBloc.error,
        ),
      ));
    }
  }

  Future<void> _onGetPdfReport(
      GetPdfReportEvent event, Emitter<ReportsState> emit) async {
    emit(state.copyWith(formStatus: LoadingState(mensaje: 'Generando PDF...')));
    try {
      var device = await getDeviceInfo();
      var deviceInfo = new Usuario(
        deviceId: device.deviceId,
        deviceBrand: device.deviceBrand,
        deviceModel: device.deviceModel,
        deviceName: device.deviceName,
        serialNumber: device.serialNumber,
        creadoEn: device.creadoEn,
        activo: device.activo,
      );
      var reqReportModel = ReqReportModel(
        fechaDesde: event.fechaDesde,
        fechaHasta: event.fechaHasta,
        tipo: event.tipo,
        usuario: deviceInfo,
      );
      final response =
          await repository.obtenerPdfReporte(reqReportModel: reqReportModel);
      if (response.status) {
        if (response.status == true && response.data!.data!.pdfBase64 != null) {
          final pdfBytes = base64.decode(response.data!.data!.pdfBase64!);
          final directory = await getTemporaryDirectory();
          final file = File(
              '${directory.path}/Reporte_${DateTime.now().millisecondsSinceEpoch}.pdf');
          await file.writeAsBytes(pdfBytes);
          emit(state.copyWith(
            formStatus: PdfReadyState(pdfPath: file.path),
          ));
        } else {
          emit(state.copyWith(
            formStatus: MessageState(
              mensaje: response.mensaje,
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
    }
  }

  Future<void> _onGetDataReport(
      GetDataReportEvent event, Emitter<ReportsState> emit) async {
    emit(state.copyWith(
        formStatus: LoadingState(mensaje: 'Obteniendo Informacion...')));
    try {
      var device = await getDeviceInfo();
      var user = new Usuario(
        deviceId: device.deviceId,
        deviceBrand: device.deviceBrand,
        deviceModel: device.deviceModel,
        deviceName: device.deviceName,
        serialNumber: device.serialNumber,
        creadoEn: device.creadoEn,
        activo: device.activo,
      );
      var reqReportModel = ReqReportModel(
        fechaDesde: event.fechaDesde,
        fechaHasta: event.fechaHasta,
        tipo: event.tipo,
        usuario: user,
      );
      final response =
          await repository.obtenerDataReporte(reqReportModel: reqReportModel);
      if (response.status) {
        emit(state.copyWith(
          formStatus: RecibirDataReportState(response: response.data!),
        ));
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
    }
  }
}
