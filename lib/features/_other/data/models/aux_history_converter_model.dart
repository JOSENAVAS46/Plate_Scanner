// To parse this JSON data, do
//
//     final auxHistoryConverterModel = auxHistoryConverterModelFromJson(jsonString);

import 'dart:convert';

AuxHistoryConverterModel auxHistoryConverterModelFromJson(String str) =>
    AuxHistoryConverterModel.fromJson(json.decode(str));

String auxHistoryConverterModelToJson(AuxHistoryConverterModel data) =>
    json.encode(data.toJson());

class AuxHistoryConverterModel {
  int? id;
  String? tipo;
  String? objeto;
  String? base64Img;

  AuxHistoryConverterModel({
    this.id,
    this.tipo,
    this.objeto,
    this.base64Img,
  });

  factory AuxHistoryConverterModel.fromJson(Map<String, dynamic> json) =>
      AuxHistoryConverterModel(
        id: json["id"],
        tipo: json["tipo"],
        objeto: json["objeto"],
        base64Img: json["base64Img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "objeto": objeto,
        "base64Img": base64Img,
      };
}
