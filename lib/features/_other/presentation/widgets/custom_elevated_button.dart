import 'package:flutter/material.dart';
import 'package:plate_scanner_app/core/styles/style_adm.dart';
import 'package:plate_scanner_app/core/utils/methods.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;

  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: calcularHeight(size, 6),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary
              ? StyleApp.appColorPrimary // Color principal
              : StyleApp.appColorBlanco, // Color secundario
          foregroundColor: isPrimary
              ? StyleApp.appColorBlanco // Texto blanco para el botón principal
              : StyleApp
                  .appColorPrimary, // Texto primario para el botón secundario
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: isPrimary
                ? BorderSide.none // Sin borde para el botón principal
                : BorderSide(color: StyleApp.appColorPrimary), // Borde primario
          ),
        ),
        onPressed: onPressed,
        child: Text(text,
            textAlign: TextAlign.center,
            style: isPrimary
                ? StyleApp.regularTxtStyleBlanco
                : StyleApp.regularTxtStyleBlanco
                    .copyWith(color: StyleApp.appColorPrimary)),
      ),
    );
  }
}
