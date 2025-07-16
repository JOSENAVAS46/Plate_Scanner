import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:plate_scanner_app/features/_other/presentation/pages/splash_screen.dart';
import 'package:plate_scanner_app/features/history/presentation/pages/history_screen.dart';
import 'package:plate_scanner_app/features/home/presentation/pages/dashboard_screen.dart';
import 'package:plate_scanner_app/features/identification/presentation/pages/identification_screen.dart';
import 'package:plate_scanner_app/features/identification/presentation/pages/image_plate_input_plate_screen.dart';
import 'package:plate_scanner_app/features/identification/presentation/pages/vehiculo_detail_screen.dart';
import 'package:plate_scanner_app/features/input_plate/presentation/pages/input_plate_screen.dart';
import 'package:plate_scanner_app/features/reports/presentation/pages/reports_screen.dart';
import 'package:plate_scanner_app/features/settings/presentation/pages/permissions_screen.dart';
import 'package:plate_scanner_app/features/settings/presentation/pages/settings_screen.dart';

class Routes {
  static const initialRoute = '/';

  static Route<dynamic> routeSettings(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) {
          return const SplashScreen();
        });
      case '/dashboard':
        return MaterialPageRoute(builder: (context) {
          return const DashboardScreen();
        });
      case '/settings':
        return MaterialPageRoute(builder: (context) {
          return const SettingsScreen();
        });
      case '/identification':
        return MaterialPageRoute(builder: (context) {
          return const IdentificationScreen();
        });
      case '/reports':
        return MaterialPageRoute(builder: (context) {
          return const ReportsScreen();
        });
      case '/permissions':
        return MaterialPageRoute(builder: (context) {
          return const PermissionsScreen();
        });
      case '/input_plate':
        return MaterialPageRoute(builder: (context) {
          return const InputPlateScreen();
        });
      case '/history':
        return MaterialPageRoute(builder: (context) {
          return const HistoryScreen();
        });
      case '/vehiculo_detail':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (context) {
          return VehiculoDetailScreen(
            imagePath: args['imagePath'],
            vehiculo: args['vehiculo'],
          );
        });
      case '/input_plate_with_image':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (context) {
          return ImagePlateInputPlateScreen(
            imagePath: args['imagePath'],
          );
        });

      default:
        return PageTransition(
            type: PageTransitionType.fade,
            child: Scaffold(
              body: Center(
                  child: Text(
                      'No existe una Pagina para la ruta: ${settings.name}')),
            ));
    }
  }
}
