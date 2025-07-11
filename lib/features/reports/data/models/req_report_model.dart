import 'dart:convert';

ReqReportModel reqReportModelFromJson(String str) =>
    ReqReportModel.fromJson(json.decode(str));

String reqReportModelToJson(ReqReportModel data) => json.encode(data.toJson());

class ReqReportModel {
  Usuario? usuario;
  DateTime? fechaDesde;
  DateTime? fechaHasta;
  String? tipo;

  ReqReportModel({
    this.usuario,
    this.fechaDesde,
    this.fechaHasta,
    this.tipo,
  });

  factory ReqReportModel.fromJson(Map<String, dynamic> json) => ReqReportModel(
        usuario:
            json["usuario"] == null ? null : Usuario.fromJson(json["usuario"]),
        fechaDesde: json["fecha_desde"] == null
            ? null
            : DateTime.parse(json["fecha_desde"]),
        fechaHasta: json["fecha_hasta"] == null
            ? null
            : DateTime.parse(json["fecha_hasta"]),
        tipo: json["tipo"],
      );

  Map<String, dynamic> toJson() => {
        "usuario": usuario?.toJson(),
        "fecha_desde":
            "${fechaDesde!.year.toString().padLeft(4, '0')}-${fechaDesde!.month.toString().padLeft(2, '0')}-${fechaDesde!.day.toString().padLeft(2, '0')}",
        "fecha_hasta":
            "${fechaHasta!.year.toString().padLeft(4, '0')}-${fechaHasta!.month.toString().padLeft(2, '0')}-${fechaHasta!.day.toString().padLeft(2, '0')}",
        "tipo": tipo,
      };
}

class Usuario {
  String? deviceId;
  String? deviceBrand;
  String? deviceModel;
  String? deviceName;
  String? serialNumber;
  DateTime? creadoEn;
  bool? activo;

  Usuario({
    this.deviceId,
    this.deviceBrand,
    this.deviceModel,
    this.deviceName,
    this.serialNumber,
    this.creadoEn,
    this.activo,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
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
