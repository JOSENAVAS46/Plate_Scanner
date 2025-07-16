import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:plate_scanner_app/core/network/api_response_model.dart';
import 'package:plate_scanner_app/core/network/http_network.dart';

class ErrorResponsesMethods {
  void printHttpError(HttpError error) {
    print('<============ ERROR ============>');
    print('Error: ${error.data}');
    print('Exception: ${error.exeception}');
    print('StackTrace: ${error.stackTrace}');
  }

  void printResponseMessageError(String message) {
    print('<============ MESSAGE ERROR ============>');
    print('Error: $message');
  }
}

Future<ApiResponseModel<T>> errorElse<T>({required HttpResult result}) async {
  if (result.statusCode == -1) {
    return ApiResponseModel<T>(
      mensaje: 'Problemas de Conexion con el Servidor.\n'
          'Verifique su conexion a internet.\n'
          'STATUSCODE[${result.statusCode}]',
      data: null,
      status: false,
    );
  } else if (result.statusCode == 400) {
    var dat = jsonDecode(result.error!.data);
    if (dat != null) {
      return ApiResponseModel<T>(
        mensaje: dat['message'],
        data: null,
        status: false,
      );
    } else {
      return ApiResponseModel<T>(
        mensaje: '${result.error!.data.message}\n'
            'STATUSCODE[${result.statusCode}]',
        data: null,
        status: false,
      );
    }
  } else if (result.statusCode == 401) {
    return ApiResponseModel<T>(
      mensaje: 'Tu sesión ha expirado. Inicia sesión nuevamente para continuar',
      data: null,
      status: false,
    );
  } else if (result.statusCode == 404) {
    return ApiResponseModel<T>(
      mensaje: '${result.error!.data.message}\n'
          'STATUSCODE[${result.statusCode}]',
      data: null,
      status: false,
    );
  } else if (result.statusCode == 500) {
    return ApiResponseModel<T>(
      mensaje: 'Error en el Servidor de la App\n'
          'STATUSCODE[${result.statusCode}]',
      data: null,
      status: false,
    );
  } else {
    if (result.error!.exeception != null) {
      return ApiResponseModel<T>(
        mensaje: 'Error Inesperado, Comuniquese con Soporte'
            '\ny proporcione la siguiente informacion:'
            '\nExecepcion: ${result.error!.exeception}'
            '\n[STATUSCODE${result.statusCode}]',
        data: null,
        status: false,
      );
    } else {
      return ApiResponseModel<T>(
        mensaje: 'Error Inesperado, Comuniquese con Soporte'
            '\ny proporcione la siguiente informacion'
            '\n STATUSCODE[${result.statusCode}]',
        data: null,
        status: false,
      );
    }
  }
}

Future<ApiResponseModel<T>> errorCatch<T>({required Object execepcion}) async {
  return ApiResponseModel<T>(
    mensaje: 'Error:\n'
        '${execepcion.toString()}',
    data: null,
    status: false,
  );
}

String getErrorMessage(Exception e) {
  if (e is SocketException) return 'Error de conexión';
  if (e is TimeoutException) return 'Tiempo de espera agotado';
  return e.toString().replaceFirst('Exception: ', '');
}
