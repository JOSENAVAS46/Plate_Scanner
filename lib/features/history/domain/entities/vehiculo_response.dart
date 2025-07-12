// vehiculo_response_model.dart
class VehiculoResponse {
  final int idConsulta;
  final int idUsuario;
  final int idVehiculo;
  final String timestamp;
  final VehiculoInfo vehiculo;

  VehiculoResponse({
    required this.idConsulta,
    required this.idUsuario,
    required this.idVehiculo,
    required this.timestamp,
    required this.vehiculo,
  });

  factory VehiculoResponse.fromJson(Map<String, dynamic> json) {
    return VehiculoResponse(
      idConsulta: json['id_consulta'],
      idUsuario: json['id_usuario'],
      idVehiculo: json['id_vehiculo'],
      timestamp: json['timestamp'],
      vehiculo: VehiculoInfo.fromJson(json['vehiculo']),
    );
  }
}

class VehiculoInfo {
  final String anio;
  final String anioMatricula;
  final String clase;
  final String color;
  final String fechaCaducidad;
  final String fechaMatricula;
  final String marca;
  final String modelo;
  final String placa;
  final String polarizado;
  final String servicio;

  VehiculoInfo({
    required this.anio,
    required this.anioMatricula,
    required this.clase,
    required this.color,
    required this.fechaCaducidad,
    required this.fechaMatricula,
    required this.marca,
    required this.modelo,
    required this.placa,
    required this.polarizado,
    required this.servicio,
  });

  factory VehiculoInfo.fromJson(Map<String, dynamic> json) {
    return VehiculoInfo(
      anio: json['anio'],
      anioMatricula: json['anio_matricula'],
      clase: json['clase'],
      color: json['color'],
      fechaCaducidad: json['fecha_caducidad'],
      fechaMatricula: json['fecha_matricula'],
      marca: json['marca'],
      modelo: json['modelo'],
      placa: json['placa'],
      polarizado: json['polarizado'],
      servicio: json['servicio'],
    );
  }
}
