import 'package:plate_scanner_app/core/mocks/app_info.dart';
import 'package:plate_scanner_app/core/styles/style_adm.dart';
import 'package:flutter/material.dart';

class DialogsAdm {
  static double iconSize = 30;

  // Estilo común para los botones
  static ButtonStyle _buttonStyle(bool primary) => ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          primary ? StyleApp.appColorPrimary : StyleApp.appColorBlanco,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
              color: StyleApp.appColorPrimary,
              width: 1.5,
            ),
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      );

  // Texto común para los botones
  static Widget _buttonText(String text, bool primary) => Text(
        text,
        style: StyleApp.smallTxtStyleBold.copyWith(
          color: primary ? StyleApp.appColorBlanco : StyleApp.appColorPrimary,
        ),
      );

  static void msjSistema({
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
                  style: StyleApp.bigTitleStyle.copyWith(
                    fontSize: 12,
                    color: StyleApp.appColorBlanco,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Icon(
                  Icons.info_outline,
                  color: Colors.amberAccent,
                  size: iconSize,
                ),
              ),
            ],
          ),
          contentPadding: const EdgeInsets.all(15),
          content: Text(
            mensaje,
            style: StyleApp.regularTxtStyle.copyWith(
              fontSize: 12,
              color: StyleApp.appColorBlanco,
            ),
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                style: _buttonStyle(true),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onConfirm != null) onConfirm();
                },
                child: _buttonText('Aceptar', true),
              ),
            ),
          ],
        );
      },
    );
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
                  style: StyleApp.bigTitleStyle.copyWith(
                    fontSize: 12,
                    color: StyleApp.appColorBlanco,
                  ),
                ),
              ),
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
            style: StyleApp.regularTxtStyle.copyWith(
              fontSize: 12,
              color: StyleApp.appColorBlanco,
            ),
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                style: _buttonStyle(true),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onConfirm != null) onConfirm();
                },
                child: _buttonText('Aceptar', true),
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
                  style: StyleApp.bigTitleStyle.copyWith(
                    fontSize: 12,
                    color: StyleApp.appColorBlanco,
                  ),
                ),
              ),
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
            style: StyleApp.regularTxtStyle.copyWith(
              fontSize: 12,
              color: StyleApp.appColorBlanco,
            ),
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                style: _buttonStyle(true),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onConfirm != null) onConfirm();
                },
                child: _buttonText('Aceptar', true),
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
                  style: StyleApp.bigTitleStyle.copyWith(
                    fontSize: 12,
                    color: StyleApp.appColorBlanco,
                  ),
                ),
              ),
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
            style: StyleApp.regularTxtStyle.copyWith(
              fontSize: 14,
              color: StyleApp.appColorBlanco,
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: TextButton(
                      style: _buttonStyle(false),
                      onPressed: () {
                        Navigator.of(context).pop();
                        onCancel();
                      },
                      child: _buttonText('No', false),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: TextButton(
                      style: _buttonStyle(true),
                      onPressed: () {
                        Navigator.of(context).pop();
                        onConfirm();
                      },
                      child: _buttonText('Sí', true),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
