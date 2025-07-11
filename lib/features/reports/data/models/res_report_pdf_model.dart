import 'dart:convert';

ResReportPdfModel resReportPdfModelFromJson(String str) =>
    ResReportPdfModel.fromJson(json.decode(str));

String resReportPdfModelToJson(ResReportPdfModel data) =>
    json.encode(data.toJson());

class ResReportPdfModel {
  Data? data;
  dynamic errorCode;
  String? message;
  bool? success;

  ResReportPdfModel({
    this.data,
    this.errorCode,
    this.message,
    this.success,
  });

  factory ResReportPdfModel.fromJson(Map<String, dynamic> json) =>
      ResReportPdfModel(
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
  String? contentType;
  String? pdfBase64;

  Data({
    this.contentType,
    this.pdfBase64,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        contentType: json["content_type"],
        pdfBase64: json["pdf_base64"],
      );

  Map<String, dynamic> toJson() => {
        "content_type": contentType,
        "pdf_base64": pdfBase64,
      };
}
