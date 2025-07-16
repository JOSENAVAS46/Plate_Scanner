import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plate_scanner_app/features/_other/data/models/coordinates_model.dart';

class LocationService {
  static const double _acceptableAccuracy = 50; // metros de precisión aceptable
  static const int _maxAttempts =
      3; // intentos máximos para obtener buena precisión
  static const Duration _timeout = Duration(seconds: 15); // timeout máximo

  /// Verifica y solicita permisos de ubicación
  static Future<bool> _checkLocationPermissions() async {
    try {
      var status = await Permission.location.status;
      if (!status.isGranted) {
        status = await Permission.location.request();
        if (!status.isGranted) {
          return false;
        }
      }

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return await Geolocator.openLocationSettings()
            .then((value) => false)
            .catchError((_) => false);
      }

      return true;
    } catch (e) {
      print('Error verificando permisos: $e');
      return false;
    }
  }

  /// Obtiene coordenadas con mejor precisión
  static Future<CoordinatesModel?> getPreciseCoordinates() async {
    try {
      bool hasPermission = await _checkLocationPermissions();
      if (!hasPermission) return null;

      Position? bestPosition;
      int attempts = 0;
      DateTime startTime = DateTime.now();

      while (attempts < _maxAttempts &&
          DateTime.now().difference(startTime) < _timeout) {
        try {
          Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.bestForNavigation,
            timeLimit: _timeout,
          );

          // Si la precisión es aceptable o es la mejor hasta ahora
          if (position.accuracy != null &&
              position.accuracy! <= _acceptableAccuracy) {
            return CoordinatesModel(
              latitude: position.latitude.toString(),
              longitude: position.longitude.toString(),
            );
          }

          if (bestPosition == null ||
              (position.accuracy ?? double.infinity) <
                  (bestPosition.accuracy ?? double.infinity)) {
            bestPosition = position;
          }

          attempts++;
          await Future.delayed(Duration(seconds: 1)); // Espera entre intentos
        } catch (e) {
          print('Intento $attempts fallido: $e');
          attempts++;
        }
      }

      // Si no se obtuvo una posición con buena precisión, devolver la mejor disponible
      if (bestPosition != null) {
        return CoordinatesModel(
          latitude: bestPosition.latitude.toString(),
          longitude: bestPosition.longitude.toString(),
        );
      }

      return null;
    } catch (e) {
      print('Error crítico obteniendo coordenadas: $e');
      return null;
    }
  }

  /// Obtiene la última posición conocida (más rápido)
  static Future<CoordinatesModel?> getLastKnownPosition() async {
    try {
      bool hasPermission = await _checkLocationPermissions();
      if (!hasPermission) return null;

      Position? position = await Geolocator.getLastKnownPosition();
      if (position != null) {
        return CoordinatesModel(
          latitude: position.latitude.toString(),
          longitude: position.longitude.toString(),
        );
      }
      return null;
    } catch (e) {
      print('Error obteniendo última posición conocida: $e');
      return null;
    }
  }
}
