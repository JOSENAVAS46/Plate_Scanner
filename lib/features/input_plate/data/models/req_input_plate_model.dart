// To parse this JSON data, do
//
//     final resDetectModel = resDetectModelFromJson(jsonString);

import 'dart:convert';

ReqInputPlateModel resDetectModelFromJson(String str) =>
    ReqInputPlateModel.fromJson(json.decode(str));

String resDetectModelToJson(ReqInputPlateModel data) =>
    json.encode(data.toJson());

class ReqInputPlateModel {
  UsuarioReqInputPlateModel? usuario;
  String? longitud;
  String? latitud;
  String? placa;

  ReqInputPlateModel({
    this.usuario,
    this.longitud,
    this.latitud,
    this.placa,
  });

  factory ReqInputPlateModel.fromJson(Map<String, dynamic> json) =>
      ReqInputPlateModel(
        usuario: json["usuario"] == null
            ? null
            : UsuarioReqInputPlateModel.fromJson(json["usuario"]),
        longitud: json["longitud"],
        latitud: json["latitud"],
        placa: json["placa"],
      );

  Map<String, dynamic> toJson() => {
        "usuario": usuario?.toJson(),
        "longitud": longitud,
        "latitud": latitud,
        "placa": placa,
      };
}

class UsuarioReqInputPlateModel {
  String? deviceId;
  String? deviceBrand;
  String? deviceModel;
  String? deviceName;
  String? serialNumber;
  DateTime? creadoEn;
  bool? activo;

  UsuarioReqInputPlateModel({
    this.deviceId,
    this.deviceBrand,
    this.deviceModel,
    this.deviceName,
    this.serialNumber,
    this.creadoEn,
    this.activo,
  });

  factory UsuarioReqInputPlateModel.fromJson(Map<String, dynamic> json) =>
      UsuarioReqInputPlateModel(
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
