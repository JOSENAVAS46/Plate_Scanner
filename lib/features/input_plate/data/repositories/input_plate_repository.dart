import 'package:plate_scanner_app/core/network/api_response_model.dart';
import 'package:plate_scanner_app/features/_other/data/models/res_detect_input_model.dart';
import 'package:plate_scanner_app/features/input_plate/data/models/req_input_plate_model.dart';

abstract class InputPlateRepository {
  Future<ApiResponseModel<ResDetectInputModel>> enviarInputPlaca(
      {required ReqInputPlateModel reqInputPlateModel});
}
