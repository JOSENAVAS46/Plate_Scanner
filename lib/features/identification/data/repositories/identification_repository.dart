import 'package:plate_scanner_app/core/network/api_response_model.dart';
import 'package:plate_scanner_app/features/identification/data/models/req_detect_model.dart';
import 'package:plate_scanner_app/features/_other/data/models/res_detect_input_model.dart';

abstract class IdentificationRepository {
  Future<ApiResponseModel<ResDetectInputModel>> enviarImagenEnBytes(
      {required ReqDetectModel reqDetectModel});
}
