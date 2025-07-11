// To parse this JSON data, do
//
//     final erroElseModel = erroElseModelFromJson(jsonString);

import 'dart:convert';

ErrorElseModel erroElseModelFromJson(String str) =>
    ErrorElseModel.fromJson(json.decode(str));

String erroElseModelToJson(ErrorElseModel data) => json.encode(data.toJson());

class ErrorElseModel {
  dynamic data;
  int? errorCode;
  String? message;
  bool? success;

  ErrorElseModel({
    this.data,
    this.errorCode,
    this.message,
    this.success,
  });

  factory ErrorElseModel.fromJson(Map<String, dynamic> json) => ErrorElseModel(
        data: json["data"],
        errorCode: json["error_code"],
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "error_code": errorCode,
        "message": message,
        "success": success,
      };
}
