import 'package:plate_scanner_app/core/mocks/app_info.dart';
import 'package:plate_scanner_app/core/styles/style_adm.dart';
import 'package:flutter/material.dart';
import 'package:plate_scanner_app/features/_other/data/models/res_detect_input_model.dart';

class DialogsAdm {
  static double iconSize = 30;
  static void msjSistema(
      {required BuildContext context,
      required String mensaje,
      VoidCallback? onConfirm}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            titlePadding: const EdgeInsets.all(10),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 4,
                    child: Text(
                      AppInfo().appName,
                      style: StyleApp.bigTitleStyle.copyWith(
                          fontSize: 12, color: StyleApp.appColorBlanco),
                    )),
                Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.info_outline,
                    color: Colors.amberAccent,
                    size: iconSize,
                  ),
                )
              ],
            ),
            contentPadding: const EdgeInsets.all(15),
            content: Text(mensaje,
                style: StyleApp.regularTxtStyle
                    .copyWith(fontSize: 12, color: StyleApp.appColorBlanco)),
            actions: <Widget>[
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      StyleApp.appColorPrimary),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onConfirm != null) onConfirm();
                },
                child: Text(
                  'Aceptar',
                  style: StyleApp.smallTxtStyleBold
                      .copyWith(color: StyleApp.appColorBlanco),
                ),
              ),
            ],
          );
        });
  }

  static void msjError({
    required BuildContext context,
    required String mensaje,
    VoidCallback? onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          titlePadding: const EdgeInsets.all(10),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 4,
                  child: Text(
                    AppInfo().appName,
                    style: StyleApp.bigTitleStyle
                        .copyWith(fontSize: 12, color: StyleApp.appColorBlanco),
                  )),
              Expanded(
                flex: 1,
                child: Icon(
                  Icons.error_outline_rounded,
                  color: Colors.red,
                  size: iconSize,
                ),
              ),
            ],
          ),
          contentPadding: const EdgeInsets.all(15),
          content: Text(
            mensaje,
            style: StyleApp.regularTxtStyle
                .copyWith(fontSize: 12, color: StyleApp.appColorBlanco),
          ),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(StyleApp.appColorPrimary),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                if (onConfirm != null) onConfirm();
              },
              child: Text(
                'Aceptar',
                style: StyleApp.smallTxtStyleBold
                    .copyWith(color: StyleApp.appColorBlanco),
              ),
            ),
          ],
        );
      },
    );
  }

  static void msjExito({
    required BuildContext context,
    required String mensaje,
    VoidCallback? onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          titlePadding: const EdgeInsets.all(10),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 4,
                  child: Text(
                    AppInfo().appName,
                    style: StyleApp.bigTitleStyle
                        .copyWith(fontSize: 12, color: StyleApp.appColorBlanco),
                  )),
              Expanded(
                flex: 1,
                child: Icon(
                  Icons.check_circle_outline_rounded,
                  color: Colors.green,
                  size: iconSize,
                ),
              ),
            ],
          ),
          contentPadding: const EdgeInsets.all(15),
          content: Text(
            mensaje,
            style: StyleApp.regularTxtStyle
                .copyWith(fontSize: 12, color: StyleApp.appColorBlanco),
          ),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(StyleApp.appColorPrimary),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                if (onConfirm != null) onConfirm();
              },
              child: Text(
                'Aceptar',
                style: StyleApp.smallTxtStyleBold
                    .copyWith(color: StyleApp.appColorBlanco),
              ),
            ),
          ],
        );
      },
    );
  }

  static void mostrarPregunta({
    required BuildContext context,
    required String mensaje,
    required VoidCallback onConfirm,
    required VoidCallback onCancel,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          titlePadding: const EdgeInsets.all(10),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 4,
                  child: Text(
                    AppInfo().appName,
                    style: StyleApp.bigTitleStyle
                        .copyWith(fontSize: 12, color: StyleApp.appColorBlanco),
                  )),
              Expanded(
                flex: 1,
                child: Icon(
                  Icons.help_outline,
                  color: Colors.blue,
                  size: iconSize,
                ),
              ),
            ],
          ),
          contentPadding: const EdgeInsets.all(15),
          content: Text(
            mensaje,
            style: StyleApp.regularTxtStyle
                .copyWith(fontSize: 14, color: StyleApp.appColorBlanco),
          ),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(StyleApp.appColorBlanco),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                onCancel();
              },
              child: Text(
                'No',
                style: StyleApp.smallTxtStyleBold
                    .copyWith(color: StyleApp.appColorPrimary),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(StyleApp.appColorPrimary),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
              child: Text(
                'Sí',
                style: StyleApp.smallTxtStyleBold
                    .copyWith(color: StyleApp.appColorBlanco),
              ),
            ),
          ],
        );
      },
    );
  }

  static void alertVehiculo({
    required BuildContext context,
    required Vehiculo veh,
    VoidCallback? onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          titlePadding: const EdgeInsets.all(10),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Información del Vehículo',
                style: StyleApp.bigTitleStyle
                    .copyWith(fontSize: 16, color: StyleApp.appColorBlanco),
              ),
              Icon(
                Icons.directions_car,
                color: StyleApp.appColorPrimary,
                size: 30,
              ),
            ],
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildInfoRow('Placa:', veh.placa ?? 'No disponible'),
                _buildInfoRow('Marca:', veh.marca ?? 'No disponible'),
                _buildInfoRow('Modelo:', veh.modelo ?? 'No disponible'),
                _buildInfoRow('Año:', veh.anio ?? 'No disponible'),
                _buildInfoRow('Color:', veh.color ?? 'No disponible'),
                _buildInfoRow('Clase:', veh.clase ?? 'No disponible'),
                _buildInfoRow('Servicio:', veh.servicio ?? 'No disponible'),
                _buildInfoRow('Polarizado:', veh.polarizado ?? 'No disponible'),
                _buildInfoRow(
                    'Matriculado:', veh.anioMatricula ?? 'No disponible'),
                _buildInfoRow(
                    'Fecha Matrícula:', veh.fechaMatricula ?? 'No disponible'),
                _buildInfoRow(
                    'Caducidad:', veh.fechaCaducidad ?? 'No disponible'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(StyleApp.appColorPrimary),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                if (onConfirm != null) onConfirm();
              },
              child: Text(
                'Aceptar',
                style: StyleApp.smallTxtStyleBold
                    .copyWith(color: StyleApp.appColorBlanco),
              ),
            ),
          ],
        );
      },
    );
  }

// Helper method to build consistent info rows
  static Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: label,
              style: StyleApp.regularTxtStyle.copyWith(
                fontSize: 14,
                color: StyleApp.appColorBlanco,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: ' $value',
              style: StyleApp.regularTxtStyle.copyWith(
                fontSize: 14,
                color: StyleApp.appColorBlanco,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
