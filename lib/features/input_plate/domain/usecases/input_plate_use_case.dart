import 'dart:convert';

import 'package:plate_scanner_app/core/cache/cache_app.dart';
import 'package:plate_scanner_app/core/errors/error_responses_methods.dart';
import 'package:plate_scanner_app/core/network/api_response_model.dart';
import 'package:plate_scanner_app/core/network/http_network.dart';
import 'package:plate_scanner_app/features/_other/data/models/res_detect_input_model.dart';
import 'package:plate_scanner_app/features/input_plate/data/models/req_input_plate_model.dart';
import 'package:plate_scanner_app/features/input_plate/data/repositories/input_plate_repository.dart';

class InputPlateUseCase extends InputPlateRepository {
  final HttpNetworkSettings httpNetworkSettings = HttpNetworkSettings();
  final CacheApp cacheApp = CacheApp();

  @override
  Future<ApiResponseModel<ResDetectInputModel>> enviarInputPlaca(
      {required ReqInputPlateModel reqInputPlateModel}) async {
    try {
      final res = await httpNetworkSettings.startSettings(
        cacheApp.getApiUrl(),
        'vehiculo/obtener_info',
        body: reqInputPlateModel.toJson(),
        method: HttpMethod.post,
        parser: (data) => jsonDecode(data) as Map<String, dynamic>,
      );
      if (res.statusCode == 200) {
        final data = ResDetectInputModel.fromJson(res.data!);
        return ApiResponseModel(
            status: true, mensaje: 'Imagen procesada', data: data);
      } else if (res.statusCode == 400) {
        final data = ResDetectInputModel.fromJson(jsonDecode(res.error!.data!));
        return ApiResponseModel(
            status: false, mensaje: data.message!, data: data);
      } else if (res.statusCode == 404) {
        final data = ResDetectInputModel.fromJson(jsonDecode(res.error!.data!));
        return ApiResponseModel(
            status: false, mensaje: data.message!, data: data);
      } else {
        return errorElse(result: res);
      }
    } catch (e) {
      return errorCatch(execepcion: e);
    }
  }
}
