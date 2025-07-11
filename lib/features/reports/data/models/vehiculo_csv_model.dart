class VehiculoCsvModel {
  final String placa;
  final String marca;
  final String modelo;
  final int anio;
  final String color;
  final String clase;
  final String fechaMatricula;
  final int anioMatricula;
  final String servicio;
  final String fechaCaducidad;
  final String polarizado;

  VehiculoCsvModel({
    required this.placa,
    required this.marca,
    required this.modelo,
    required this.anio,
    required this.color,
    required this.clase,
    required this.fechaMatricula,
    required this.anioMatricula,
    required this.servicio,
    required this.fechaCaducidad,
    required this.polarizado,
  });

  factory VehiculoCsvModel.fromJson(Map<String, dynamic> json) {
    return VehiculoCsvModel(
      placa: json['placa'],
      marca: json['marca'],
      modelo: json['modelo'],
      anio: int.tryParse(json['anio'].toString()) ?? 0,
      color: json['color'],
      clase: json['clase'],
      fechaMatricula: json['fecha_matricula'],
      anioMatricula: int.tryParse(json['anio_matricula'].toString()) ?? 0,
      servicio: json['servicio'],
      fechaCaducidad: json['fecha_caducidad'],
      polarizado: json['polarizado'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'placa': placa,
      'marca': marca,
      'modelo': modelo,
      'anio': anio,
      'color': color,
      'clase': clase,
      'fecha_matricula': fechaMatricula,
      'anio_matricula': anioMatricula,
      'servicio': servicio,
      'fecha_caducidad': fechaCaducidad,
      'polarizado': polarizado,
    };
  }
}
