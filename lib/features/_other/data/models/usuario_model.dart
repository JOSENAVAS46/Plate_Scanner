// To parse this JSON data, do
//
//     final usuarioModel = usuarioModelFromJson(jsonString);

import 'dart:convert';

UsuarioModel usuarioModelFromJson(String str) => UsuarioModel.fromJson(json.decode(str));

String usuarioModelToJson(UsuarioModel data) => json.encode(data.toJson());

class UsuarioModel {
  String? deviceId;
  String? deviceBrand;
  String? deviceModel;
  String? deviceName;
  String? serialNumber;
  DateTime? creadoEn;
  bool? activo;

  UsuarioModel({
    this.deviceId,
    this.deviceBrand,
    this.deviceModel,
    this.deviceName,
    this.serialNumber,
    this.creadoEn,
    this.activo,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
    deviceId: json["device_id"],
    deviceBrand: json["device_brand"],
    deviceModel: json["device_model"],
    deviceName: json["device_name"],
    serialNumber: json["serial_number"],
    creadoEn: json["creado_en"] == null ? null : DateTime.parse(json["creado_en"]),
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
