// To parse this JSON data, do
//
//     final resDetectModel = resDetectModelFromJson(jsonString);

import 'dart:convert';

ResDetectInputModel resDetectModelFromJson(String str) =>
    ResDetectInputModel.fromJson(json.decode(str));

String resDetectModelToJson(ResDetectInputModel data) =>
    json.encode(data.toJson());

class ResDetectInputModel {
  Data? data;
  dynamic errorCode;
  String? message;
  bool? success;

  ResDetectInputModel({
    this.data,
    this.errorCode,
    this.message,
    this.success,
  });

  factory ResDetectInputModel.fromJson(Map<String, dynamic> json) =>
      ResDetectInputModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        errorCode: json["error_code"],
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "error_code": errorCode,
        "message": message,
        "success": success,
      };
}

class Data {
  int? idConsulta;
  int? idUsuario;
  int? idVehiculo;
  DateTime? timestamp;
  Vehiculo? vehiculo;

  Data({
    this.idConsulta,
    this.idUsuario,
    this.idVehiculo,
    this.timestamp,
    this.vehiculo,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        idConsulta: json["id_consulta"],
        idUsuario: json["id_usuario"],
        idVehiculo: json["id_vehiculo"],
        timestamp: json["timestamp"] == null
            ? null
            : DateTime.parse(json["timestamp"]),
        vehiculo: json["vehiculo"] == null
            ? null
            : Vehiculo.fromJson(json["vehiculo"]),
      );

  Map<String, dynamic> toJson() => {
        "id_consulta": idConsulta,
        "id_usuario": idUsuario,
        "id_vehiculo": idVehiculo,
        "timestamp": timestamp?.toIso8601String(),
        "vehiculo": vehiculo?.toJson(),
      };
}

class Vehiculo {
  String? anio;
  String? anioMatricula;
  String? clase;
  String? color;
  String? fechaCaducidad;
  String? fechaMatricula;
  String? marca;
  String? modelo;
  String? placa;
  String? polarizado;
  String? servicio;

  Vehiculo({
    this.anio,
    this.anioMatricula,
    this.clase,
    this.color,
    this.fechaCaducidad,
    this.fechaMatricula,
    this.marca,
    this.modelo,
    this.placa,
    this.polarizado,
    this.servicio,
  });

  factory Vehiculo.fromJson(Map<String, dynamic> json) => Vehiculo(
        anio: json["anio"],
        anioMatricula: json["anio_matricula"],
        clase: json["clase"],
        color: json["color"],
        fechaCaducidad: json["fecha_caducidad"],
        fechaMatricula: json["fecha_matricula"],
        marca: json["marca"],
        modelo: json["modelo"],
        placa: json["placa"],
        polarizado: json["polarizado"],
        servicio: json["servicio"],
      );

  Map<String, dynamic> toJson() => {
        "anio": anio,
        "anio_matricula": anioMatricula,
        "clase": clase,
        "color": color,
        "fecha_caducidad": fechaCaducidad,
        "fecha_matricula": fechaMatricula,
        "marca": marca,
        "modelo": modelo,
        "placa": placa,
        "polarizado": polarizado,
        "servicio": servicio,
      };
}
