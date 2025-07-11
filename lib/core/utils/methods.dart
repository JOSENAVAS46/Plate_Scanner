import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

import 'package:plate_scanner_app/features/_other/data/models/usuario_model.dart';

double calcularHeight(Size size, double porcentaje) {
  return size.height * (porcentaje / 100);
}

double calcularWidth(Size size, double porcentaje) {
  return size.width * (porcentaje / 100);
}

String calcularTara(
    {required TextEditingController pesoBruto,
    required TextEditingController porcentaje}) {
  double pesoD = double.parse(pesoBruto.text);
  double porcentajeD = double.parse(porcentaje.text);
  double resultado = (pesoD * porcentajeD) / 100;
  return redondearApp(resultado);
}

String calcularPesoNeto(
    {required TextEditingController pesoBruto,
    required TextEditingController tara}) {
  double pesoBrutoD = double.parse(pesoBruto.text);
  double taraD = double.parse(tara.text);
  double resultado = pesoBrutoD - taraD;
  return resultado.toStringAsFixed(2);
}

String calcularTotalPagar(
    {required TextEditingController pesoNeto,
    required TextEditingController precioProd}) {
  double pesoNetoD = double.parse(pesoNeto.text);
  double precioProdD = double.parse(precioProd.text);
  double resultado = pesoNetoD * precioProdD;
  return resultado.toStringAsFixed(2);
}

String calcularTotalPagar2(
    {required TextEditingController pesoNeto,
    required TextEditingController precioProd}) {
  double pesoNetoD = double.parse(pesoNeto.text);
  double precioProdD = double.parse(precioProd.text);
  double resultado = pesoNetoD * precioProdD;
  return resultado.toStringAsFixed(2);
}

String calcularTotalPagarCalificacion(
    {required double pesoNeto, required double precioProd}) {
  double resultado = pesoNeto * precioProd;
  return resultado.toStringAsFixed(2);
}

String redondearApp(double valor) {
  // Ajustar ligeramente el valor antes de multiplicarlo por 100
  double valorAjustado =
      valor + 0.0000000001; // Ajuste para manejar la precisión
  double redondeado = (valorAjustado * 100).roundToDouble() / 100;
  // Devolver el valor con exactamente dos decimales
  return redondeado.toStringAsFixed(2);
}

int calcularEspacio(String prov, String labelEnunciado, String labelValor) {
  int espacio = prov.length - (labelEnunciado.length + labelValor.length);
  return espacio;
}

Future<String> getDeviceIdentifier() async {
  String deviceIdentifier = "unknown";
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceIdentifier = androidInfo.id;
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    deviceIdentifier = iosInfo.identifierForVendor ?? "unknown";
  } else if (kIsWeb) {
    // The web doesnt have a device UID, so use a combination fingerprint as an example
    WebBrowserInfo webInfo = await deviceInfo.webBrowserInfo;
    // concatenar
    deviceIdentifier =
        "${webInfo.vendor}-${webInfo.userAgent}-${webInfo.hardwareConcurrency}";
  } else if (Platform.isLinux) {
    LinuxDeviceInfo linuxInfo = await deviceInfo.linuxInfo;
    deviceIdentifier = linuxInfo.id;
  }
  return deviceIdentifier;
}

Future<UsuarioModel> getDeviceInfo() async {
  UsuarioModel device = UsuarioModel();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    device.deviceId = androidInfo.id;
    device.deviceBrand = androidInfo.brand.toUpperCase();
    device.deviceModel = androidInfo.model.toUpperCase();
    device.deviceName = androidInfo.name.toUpperCase();
    device.serialNumber = androidInfo.serialNumber.toUpperCase();
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    device.deviceId = iosInfo.identifierForVendor?.toUpperCase() ??
        iosInfo.utsname.machine.toUpperCase() ??
        'UNKNOWN';
    device.deviceBrand = 'APPLE';
    device.deviceModel = iosInfo.utsname.machine.toUpperCase();
    device.deviceName = iosInfo.name.toUpperCase();
    device.serialNumber =
        iosInfo.identifierForVendor?.toUpperCase() ?? 'UNKNOWN';
  }
  device.activo = true;
  device.creadoEn = DateTime.now();
  return device;
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
