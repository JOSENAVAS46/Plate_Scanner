import 'dart:convert';

class CoordinatesModel {
  final String latitude;
  final String longitude;

  CoordinatesModel({required this.latitude, required this.longitude});

  // Conversión a mapa
  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  // Conversión a JSON
  String toJson() => json.encode(toMap());

  // Factory para crear desde mapa
  factory CoordinatesModel.fromMap(Map<String, dynamic> map) {
    return CoordinatesModel(
      latitude: map['latitude'] ?? '',
      longitude: map['longitude'] ?? '',
    );
  }

  // Factory para crear desde JSON
  factory CoordinatesModel.fromJson(String source) =>
      CoordinatesModel.fromMap(json.decode(source));
}
