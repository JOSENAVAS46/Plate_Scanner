// To parse this JSON data, do
//
//     final reqConsultaModel = reqConsultaModelFromJson(jsonString);

import 'dart:convert';

ReqConsultaModel reqConsultaModelFromJson(String str) =>
    ReqConsultaModel.fromJson(json.decode(str));

String reqConsultaModelToJson(ReqConsultaModel data) =>
    json.encode(data.toJson());

class ReqConsultaModel {
  String? deviceId;
  String? deviceBrand;
  String? deviceModel;
  String? deviceName;
  String? serialNumber;
  DateTime? creadoEn;
  bool? activo;

  ReqConsultaModel({
    this.deviceId,
    this.deviceBrand,
    this.deviceModel,
    this.deviceName,
    this.serialNumber,
    this.creadoEn,
    this.activo,
  });

  factory ReqConsultaModel.fromJson(Map<String, dynamic> json) =>
      ReqConsultaModel(
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
