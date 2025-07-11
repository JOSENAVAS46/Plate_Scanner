import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:plate_scanner_app/core/cache/cache_app.dart';
import 'package:plate_scanner_app/core/errors/error_responses_methods.dart';
import 'package:plate_scanner_app/core/network/api_response_model.dart';
import 'package:plate_scanner_app/core/network/http_network.dart';
import 'package:plate_scanner_app/features/reports/data/models/req_consulta_model.dart';
import 'package:plate_scanner_app/features/reports/data/models/req_report_model.dart';
import 'package:plate_scanner_app/features/reports/data/models/res_consulta_model.dart';
import 'package:plate_scanner_app/features/reports/data/models/res_report_data_model.dart';
import 'package:plate_scanner_app/features/reports/data/models/res_report_pdf_model.dart';
import 'package:plate_scanner_app/features/reports/data/models/vehiculo_csv_model.dart';
import 'package:plate_scanner_app/features/reports/data/repositories/reports_repository.dart';

class ReportsUseCase extends ReportsRepository {
  final HttpNetworkSettings httpNetworkSettings = HttpNetworkSettings();
  final CacheApp cacheApp = CacheApp();

  @override
  Future<ApiResponseModel<List<VehiculoCsvModel>>> obtenerListaCsv() async {
    try {
      // 1. Cargar el archivo CSV desde assets
      final csvData = await rootBundle.loadString('assets/data/dataset.csv');

      // 2. Procesar el CSV
      final vehiculos = _parseCsvData(csvData);

      // 3. Retornar respuesta exitosa
      return ApiResponseModel(
        status: true,
        mensaje: 'Datos cargados correctamente',
        data: vehiculos,
      );
    } catch (e) {
      // 4. Manejo de errores
      return ApiResponseModel(
        status: false,
        mensaje: 'Error al cargar el CSV: ${e.toString()}',
        data: null,
      );
    }
  }

  @override
  Future<ApiResponseModel<ResConsultaModel>> obtenerConsultabyUser(
      {required ReqConsultaModel reqConsultaModel}) async {
    try {
      final res = await httpNetworkSettings.startSettings(
        cacheApp.getApiUrl(),
        'consulta/obtenerbyuser',
        body: reqConsultaModel.toJson(),
        method: HttpMethod.post,
        parser: (data) => jsonDecode(data) as Map<String, dynamic>,
      );
      if (res.statusCode == 200) {
        final data = ResConsultaModel.fromJson(res.data!);
        return ApiResponseModel(
            status: true, mensaje: 'Imagen procesada', data: data);
      } else {
        return errorElse(result: res);
      }
    } catch (e) {
      return errorCatch(execepcion: e);
    }
  }

  @override
  Future<ApiResponseModel<ResReportPdfModel>> obtenerPdfReporte(
      {required ReqReportModel reqReportModel}) async {
    try {
      final res = await httpNetworkSettings.startSettings(
        cacheApp.getApiUrl(),
        'reporte/generarpdf',
        body: reqReportModel.toJson(),
        method: HttpMethod.post,
        parser: (data) => jsonDecode(data) as Map<String, dynamic>,
      );
      if (res.statusCode == 200) {
        final data = ResReportPdfModel.fromJson(res.data!);
        return ApiResponseModel(
            status: true, mensaje: 'Imagen procesada', data: data);
      } else {
        return errorElse(result: res);
      }
    } catch (e) {
      return errorCatch(execepcion: e);
    }
  }

  @override
  Future<ApiResponseModel<ResReportDataModel>> obtenerDataReporte(
      {required ReqReportModel reqReportModel}) async {
    try {
      final res = await httpNetworkSettings.startSettings(
        cacheApp.getApiUrl(),
        'reporte/obtener',
        body: reqReportModel.toJson(),
        method: HttpMethod.post,
        parser: (data) => jsonDecode(data) as Map<String, dynamic>,
      );
      if (res.statusCode == 200) {
        final data = ResReportDataModel.fromJson(res.data!);
        return ApiResponseModel(
            status: true, mensaje: 'Imagen procesada', data: data);
      } else {
        return errorElse(result: res);
      }
    } catch (e) {
      return errorCatch(execepcion: e);
    }
  }
}

List<VehiculoCsvModel> _parseCsvData(String csvData) {
  final lines = LineSplitter.split(csvData)
      .where((line) => line.trim().isNotEmpty)
      .toList();
  if (lines.isEmpty) return [];

  // Obtener encabezados
  final headers =
      lines[0].toLowerCase().split(',').map((h) => h.trim()).toList();

  return lines.sublist(1).map((line) {
    final values = line.split(',');
    final jsonMap = <String, dynamic>{};

    for (int i = 0; i < headers.length && i < values.length; i++) {
      jsonMap[headers[i]] = values[i].trim();
    }

    return VehiculoCsvModel.fromJson(jsonMap);
  }).toList();
}
