import 'package:flutter/material.dart';
import 'package:plate_scanner_app/core/utils/methods.dart';

class SeparadorAltura extends StatelessWidget {
  final Size size;
  final double porcentaje;
  const SeparadorAltura({required this.size, required this.porcentaje});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: calcularHeight(size, porcentaje),
    );
  }
}

class SeparadorAncho extends StatelessWidget {
  final Size size;
  final double porcentaje;
  const SeparadorAncho({required this.size, required this.porcentaje});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: calcularWidth(size, porcentaje),
    );
  }
}
