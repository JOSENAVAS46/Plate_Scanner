import 'package:plate_scanner_app/core/styles/style_adm.dart';
import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() {
    return ThemeData(
        brightness: Brightness.dark,
        // primarySwatch: swatchColor,
        useMaterial3: true,
        colorSchemeSeed: StyleApp.appColorPrimary,
        listTileTheme: ListTileThemeData(
          iconColor: StyleApp.appColorNegro,
        ));
  }
}
