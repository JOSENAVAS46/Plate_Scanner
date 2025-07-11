import 'package:plate_scanner_app/core/network/api_response_model.dart';
import 'package:plate_scanner_app/features/reports/data/models/req_consulta_model.dart';
import 'package:plate_scanner_app/features/reports/data/models/req_report_model.dart';
import 'package:plate_scanner_app/features/reports/data/models/res_consulta_model.dart';
import 'package:plate_scanner_app/features/reports/data/models/res_report_data_model.dart';
import 'package:plate_scanner_app/features/reports/data/models/res_report_pdf_model.dart';
import 'package:plate_scanner_app/features/reports/data/models/vehiculo_csv_model.dart';

abstract class ReportsRepository {
  Future<ApiResponseModel<List<VehiculoCsvModel>>> obtenerListaCsv();
  Future<ApiResponseModel<ResConsultaModel>> obtenerConsultabyUser(
      {required ReqConsultaModel reqConsultaModel});
  Future<ApiResponseModel<ResReportPdfModel>> obtenerPdfReporte(
      {required ReqReportModel reqReportModel});
  Future<ApiResponseModel<ResReportDataModel>> obtenerDataReporte(
      {required ReqReportModel reqReportModel});
}
