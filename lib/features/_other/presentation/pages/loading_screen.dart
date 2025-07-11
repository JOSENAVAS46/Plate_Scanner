import 'package:flutter/material.dart';
import 'package:plate_scanner_app/core/styles/style_adm.dart';
import 'package:plate_scanner_app/features/_other/presentation/widgets/separador.dart';

class LoadingScreen extends StatelessWidget {
  final String mensaje;
  const LoadingScreen({required this.mensaje});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: StyleApp.appColorPlomo,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: StyleApp.appColorPrimary,
                    ),
                    SeparadorAltura(size: size, porcentaje: 5),
                    Text(
                      mensaje,
                      style: StyleApp.bigTitleStyleBlanco,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
