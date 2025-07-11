// To parse this JSON data, do
//
//     final resReportDataModel = resReportDataModelFromJson(jsonString);

import 'dart:convert';

ResReportDataModel resReportDataModelFromJson(String str) =>
    ResReportDataModel.fromJson(json.decode(str));

String resReportDataModelToJson(ResReportDataModel data) =>
    json.encode(data.toJson());

class ResReportDataModel {
  List<Datum>? data;
  dynamic errorCode;
  String? message;
  bool? success;

  ResReportDataModel({
    this.data,
    this.errorCode,
    this.message,
    this.success,
  });

  factory ResReportDataModel.fromJson(Map<String, dynamic> json) =>
      ResReportDataModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        errorCode: json["error_code"],
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "error_code": errorCode,
        "message": message,
        "success": success,
      };
}

class Datum {
  int? anioVehiculo;
  String? claseVehiculo;
  String? colorVehiculo;
  String? estado;
  DateTime? fechaCaducidadVehiculo;
  DateTime? fechaHoraConsulta;
  DateTime? fechaMatriculaVehiculo;
  int? idConsulta;
  int? idUsuario;
  String? latitud;
  String? longitud;
  String? marcaVehiculo;
  String? modeloVehiculo;
  String? placa;
  String? polarizadoVehiculo;
  String? servicioVehiculo;
  String? tipo;

  Datum({
    this.anioVehiculo,
    this.claseVehiculo,
    this.colorVehiculo,
    this.estado,
    this.fechaCaducidadVehiculo,
    this.fechaHoraConsulta,
    this.fechaMatriculaVehiculo,
    this.idConsulta,
    this.idUsuario,
    this.latitud,
    this.longitud,
    this.marcaVehiculo,
    this.modeloVehiculo,
    this.placa,
    this.polarizadoVehiculo,
    this.servicioVehiculo,
    this.tipo,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        anioVehiculo: json["anio_vehiculo"],
        claseVehiculo: json["clase_vehiculo"]!,
        colorVehiculo: json["color_vehiculo"],
        estado: json["estado"]!,
        fechaCaducidadVehiculo: json["fecha_caducidad_vehiculo"] == null
            ? null
            : DateTime.parse(json["fecha_caducidad_vehiculo"]),
        fechaHoraConsulta: json["fecha_hora_consulta"] == null
            ? null
            : DateTime.parse(json["fecha_hora_consulta"]),
        fechaMatriculaVehiculo: json["fecha_matricula_vehiculo"] == null
            ? null
            : DateTime.parse(json["fecha_matricula_vehiculo"]),
        idConsulta: json["id_consulta"],
        idUsuario: json["id_usuario"],
        latitud: json["latitud"],
        longitud: json["longitud"],
        marcaVehiculo: json["marca_vehiculo"]!,
        modeloVehiculo: json["modelo_vehiculo"],
        placa: json["placa"],
        polarizadoVehiculo: json["polarizado_vehiculo"]!,
        servicioVehiculo: json["servicio_vehiculo"]!,
        tipo: json["tipo"]!,
      );

  Map<String, dynamic> toJson() => {
        "anio_vehiculo": anioVehiculo,
        "clase_vehiculo": claseVehiculo,
        "color_vehiculo": colorVehiculo,
        "estado": estado,
        "fecha_caducidad_vehiculo":
            "${fechaCaducidadVehiculo!.year.toString().padLeft(4, '0')}-${fechaCaducidadVehiculo!.month.toString().padLeft(2, '0')}-${fechaCaducidadVehiculo!.day.toString().padLeft(2, '0')}",
        "fecha_hora_consulta": fechaHoraConsulta?.toIso8601String(),
        "fecha_matricula_vehiculo":
            "${fechaMatriculaVehiculo!.year.toString().padLeft(4, '0')}-${fechaMatriculaVehiculo!.month.toString().padLeft(2, '0')}-${fechaMatriculaVehiculo!.day.toString().padLeft(2, '0')}",
        "id_consulta": idConsulta,
        "id_usuario": idUsuario,
        "latitud": latitud,
        "longitud": longitud,
        "marca_vehiculo": marcaVehiculo,
        "modelo_vehiculo": modeloVehiculo,
        "placa": placa,
        "polarizado_vehiculo": polarizadoVehiculo,
        "servicio_vehiculo": servicioVehiculo,
        "tipo": tipo,
      };
}
