import 'dart:async';

import 'package:flutter/material.dart';
import 'package:plate_scanner_app/core/styles/style_adm.dart';
import 'package:plate_scanner_app/features/_other/presentation/widgets/separador.dart';

class LoadingScreen extends StatefulWidget {
  final String mensaje;
  const LoadingScreen({required this.mensaje});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  int _secondsElapsed = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Start timer when widget is initialized
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _secondsElapsed++;
      });
    });
  }

  @override
  void dispose() {
    // Cancel timer when widget is disposed to avoid memory leaks
    _timer.cancel();
    super.dispose();
  }

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
                      widget.mensaje,
                      style: StyleApp.bigTitleStyleBlanco
                          .copyWith(color: StyleApp.appColorBlanco),
                      textAlign: TextAlign.center,
                    ),
                    SeparadorAltura(size: size, porcentaje: 2),
                    Text(
                      '$_secondsElapsed seg.',
                      style: StyleApp.regularTxtStyleBoldBlanco,
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
