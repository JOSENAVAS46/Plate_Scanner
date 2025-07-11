// To parse this JSON data, do
//
//     final resConsultaModel = resConsultaModelFromJson(jsonString);

import 'dart:convert';

ResConsultaModel resConsultaModelFromJson(String str) =>
    ResConsultaModel.fromJson(json.decode(str));

String resConsultaModelToJson(ResConsultaModel data) =>
    json.encode(data.toJson());

class ResConsultaModel {
  List<Datum>? data;
  String? message;
  bool? success;

  ResConsultaModel({
    this.data,
    this.message,
    this.success,
  });

  factory ResConsultaModel.fromJson(Map<String, dynamic> json) =>
      ResConsultaModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "success": success,
      };
}

class Datum {
  dynamic actualizadoEn;
  DateTime? creadoEn;
  String? estado;
  DateTime? fechaHoraConsulta;
  int? idConsulta;
  String? latitud;
  String? longitud;
  String? placa;
  String? resultado;
  int? tieneImagen;
  String? tipo;
  Vehiculo? vehiculo;

  Datum({
    this.actualizadoEn,
    this.creadoEn,
    this.estado,
    this.fechaHoraConsulta,
    this.idConsulta,
    this.latitud,
    this.longitud,
    this.placa,
    this.resultado,
    this.tieneImagen,
    this.tipo,
    this.vehiculo,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        actualizadoEn: json["actualizado_en"],
        creadoEn: json["creado_en"] == null
            ? null
            : DateTime.parse(json["creado_en"]),
        estado: json["estado"],
        fechaHoraConsulta: json["fecha_hora_consulta"] == null
            ? null
            : DateTime.parse(json["fecha_hora_consulta"]),
        idConsulta: json["id_consulta"],
        latitud: json["latitud"],
        longitud: json["longitud"],
        placa: json["placa"],
        resultado: json["resultado"],
        tieneImagen: json["tiene_imagen"],
        tipo: json["tipo"],
        vehiculo: json["vehiculo"] == null
            ? null
            : Vehiculo.fromJson(json["vehiculo"]),
      );

  Map<String, dynamic> toJson() => {
        "actualizado_en": actualizadoEn,
        "creado_en": creadoEn?.toIso8601String(),
        "estado": estado,
        "fecha_hora_consulta": fechaHoraConsulta?.toIso8601String(),
        "id_consulta": idConsulta,
        "latitud": latitud,
        "longitud": longitud,
        "placa": placa,
        "resultado": resultado,
        "tiene_imagen": tieneImagen,
        "tipo": tipo,
        "vehiculo": vehiculo?.toJson(),
      };
}

class Vehiculo {
  int? anio;
  int? anioMatricula;
  String? clase;
  String? color;
  DateTime? fechaCaducidad;
  DateTime? fechaMatricula;
  int? id;
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
    this.id,
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
        fechaCaducidad: json["fecha_caducidad"] == null
            ? null
            : DateTime.parse(json["fecha_caducidad"]),
        fechaMatricula: json["fecha_matricula"] == null
            ? null
            : DateTime.parse(json["fecha_matricula"]),
        id: json["id"],
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
        "fecha_caducidad": fechaCaducidad?.toIso8601String(),
        "fecha_matricula": fechaMatricula?.toIso8601String(),
        "id": id,
        "marca": marca,
        "modelo": modelo,
        "placa": placa,
        "polarizado": polarizado,
        "servicio": servicio,
      };
}
