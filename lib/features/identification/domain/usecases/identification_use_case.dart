import 'dart:convert';

import 'package:plate_scanner_app/core/cache/cache_app.dart';
import 'package:plate_scanner_app/core/errors/error_responses_methods.dart';
import 'package:plate_scanner_app/core/network/api_response_model.dart';
import 'package:plate_scanner_app/core/network/http_network.dart';
import 'package:plate_scanner_app/features/identification/data/models/req_detect_model.dart';
import 'package:plate_scanner_app/features/_other/data/models/res_detect_input_model.dart';
import 'package:plate_scanner_app/features/identification/data/repositories/identification_repository.dart';

class IdentificationUseCase extends IdentificationRepository {
  final HttpNetworkSettings httpNetworkSettings = HttpNetworkSettings();
  final CacheApp cacheApp = CacheApp();

  @override
  Future<ApiResponseModel<ResDetectInputModel>> enviarImagenEnBytes(
      {required ReqDetectModel reqDetectModel}) async {
    try {
      final res = await httpNetworkSettings.startSettings(
        cacheApp.getApiUrl(),
        'plate/detect',
        body: reqDetectModel.toJson(),
        method: HttpMethod.post,
        parser: (data) => jsonDecode(data) as Map<String, dynamic>,
      );
      if (res.statusCode == 200) {
        final data = ResDetectInputModel.fromJson(res.data!);
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
