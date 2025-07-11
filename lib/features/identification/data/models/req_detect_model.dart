// To parse this JSON data, do
//
//     final reqDetectModel = reqDetectModelFromJson(jsonString);

import 'dart:convert';

ReqDetectModel reqDetectModelFromJson(String str) =>
    ReqDetectModel.fromJson(json.decode(str));

String reqDetectModelToJson(ReqDetectModel data) => json.encode(data.toJson());

class ReqDetectModel {
  UsuarioReqDetectModel? usuario;
  String? longitud;
  String? latitud;
  String? image;

  ReqDetectModel({
    this.usuario,
    this.longitud,
    this.latitud,
    this.image,
  });

  factory ReqDetectModel.fromJson(Map<String, dynamic> json) => ReqDetectModel(
        usuario: json["usuario"] == null
            ? null
            : UsuarioReqDetectModel.fromJson(json["usuario"]),
        longitud: json["longitud"],
        latitud: json["latitud"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "usuario": usuario?.toJson(),
        "longitud": longitud,
        "latitud": latitud,
        "image": image,
      };
}

class UsuarioReqDetectModel {
  String? deviceId;
  String? deviceBrand;
  String? deviceModel;
  String? deviceName;
  String? serialNumber;
  DateTime? creadoEn;
  bool? activo;

  UsuarioReqDetectModel({
    this.deviceId,
    this.deviceBrand,
    this.deviceModel,
    this.deviceName,
    this.serialNumber,
    this.creadoEn,
    this.activo,
  });

  factory UsuarioReqDetectModel.fromJson(Map<String, dynamic> json) =>
      UsuarioReqDetectModel(
        deviceId: json["device_id"],
        deviceBrand: json["device_brand"],
        deviceModel: json["device_model"],
        deviceName: json["device_name"],
        serialNumber: json["serial_number"],
        creadoEn: json["creado_en"] == null
            ? null
            : DateTime.parse(json["creado_en"]),
        activo: json["activo"],
      );

  Map<String, dynamic> toJson() => {
        "device_id": deviceId,
        "device_brand": deviceBrand,
        "device_model": deviceModel,
        "device_name": deviceName,
        "serial_number": serialNumber,
        "creado_en": creadoEn?.toIso8601String(),
        "activo": activo,
      };
}
