import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plate_scanner_app/core/styles/style_adm.dart';
import 'package:plate_scanner_app/core/utils/dialogs.dart';
import 'package:plate_scanner_app/features/_other/data/models/res_detect_input_model.dart';
import 'package:plate_scanner_app/features/_other/presentation/widgets/separador.dart';
import 'package:plate_scanner_app/features/identification/presentation/blocs/identification_bloc.dart';

class VehiculoDetailScreen extends StatefulWidget {
  final String imagePath;
  final Vehiculo vehiculo;

  const VehiculoDetailScreen({
    super.key,
    required this.imagePath,
    required this.vehiculo,
  });

  @override
  State<VehiculoDetailScreen> createState() => _VehiculoDetailScreenState();
}

class _VehiculoDetailScreenState extends State<VehiculoDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: StyleApp.appColorBlanco),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Detalles del Vehículo',
          style: StyleApp.bigTitleStyleBlanco,
        ),
        centerTitle: true,
        backgroundColor: StyleApp.appColorPrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SeparadorAltura(size: size, porcentaje: 1),

            // Vehicle Image
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InteractiveViewer(
                panEnabled: true,
                minScale: 0.5,
                maxScale: 4.0,
                child: Image.file(
                  File(widget.imagePath),
                  fit: BoxFit.contain,
                  height: size.height * 0.3,
                ),
              ),
            ),

            SeparadorAltura(size: size, porcentaje: 2),

            // Vehicle Details Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                color: StyleApp.appColorBlanco,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: StyleApp.appColorPrimary,
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow('Placa:', widget.vehiculo.placa ?? 'N/A'),
                      SeparadorAltura(size: size, porcentaje: 1),
                      _buildDetailRow('Marca:', widget.vehiculo.marca ?? 'N/A'),
                      SeparadorAltura(size: size, porcentaje: 1),
                      _buildDetailRow(
                          'Modelo:', widget.vehiculo.modelo ?? 'N/A'),
                      SeparadorAltura(size: size, porcentaje: 1),
                      _buildDetailRow('Color:', widget.vehiculo.color ?? 'N/A'),
                      SeparadorAltura(size: size, porcentaje: 1),
                      _buildDetailRow(
                          'Año:', widget.vehiculo.anio?.toString() ?? 'N/A'),
                      SeparadorAltura(size: size, porcentaje: 1),
                      _buildDetailRow('Clase:', widget.vehiculo.clase ?? 'N/A'),
                      SeparadorAltura(size: size, porcentaje: 1),
                      _buildDetailRow(
                          'Servicio:', widget.vehiculo.servicio ?? 'N/A'),
                      SeparadorAltura(size: size, porcentaje: 1),
                      _buildDetailRow('Fecha Mat:',
                          widget.vehiculo.fechaMatricula ?? 'N/A'),
                      SeparadorAltura(size: size, porcentaje: 1),
                      _buildDetailRow('Fecha Cad:',
                          widget.vehiculo.fechaCaducidad ?? 'N/A'),
                      SeparadorAltura(size: size, porcentaje: 1),
                      _buildDetailRow(
                          'Polarizado:', widget.vehiculo.polarizado ?? 'N/A'),
                    ],
                  ),
                ),
              ),
            ),
            SeparadorAltura(size: size, porcentaje: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: StyleApp.appColorPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        // Navigate TO dashboard
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/dashboard', (route) => false);
                      },
                      child: Text(
                        'Volver',
                        style: StyleApp.regularTxtStyleBlanco,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SeparadorAltura(size: size, porcentaje: 2),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: StyleApp.regularTxtStyleBold,
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            value,
            style: StyleApp.regularTxtStyle,
          ),
        ),
      ],
    );
  }
}
