import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plate_scanner_app/features/_other/data/models/coordinates_model.dart';

class LocationService {
  /// Verifica y solicita permisos de ubicación
  static Future<bool> _checkLocationPermissions() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permiso denegado permanentemente, debes guiar al usuario a ajustes
      await openAppSettings();
      return false;
    }

    return true;
  }

  /// Obtiene la latitud actual
  static Future<String?> getLatitude() async {
    try {
      bool hasPermission = await _checkLocationPermissions();
      if (!hasPermission) return null;

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      return position.latitude.toString();
    } catch (e) {
      print('Error obteniendo latitud: $e');
      return null;
    }
  }

  /// Obtiene la longitud actual
  static Future<String?> getLongitude() async {
    try {
      bool hasPermission = await _checkLocationPermissions();
      if (!hasPermission) return null;

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      return position.longitude.toString();
    } catch (e) {
      print('Error obteniendo longitud: $e');
      return null;
    }
  }

  /// Obtiene ambas coordenadas juntas (más eficiente)
  static Future<CoordinatesModel?> getCoordinates() async {
    try {
      bool hasPermission = await _checkLocationPermissions();
      if (!hasPermission) return null;

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      return CoordinatesModel(
          latitude: position.latitude.toString(),
          longitude: position.longitude.toString());
    } catch (e) {
      print('Error obteniendo coordenadas: $e');
      return null;
    }
  }
}
