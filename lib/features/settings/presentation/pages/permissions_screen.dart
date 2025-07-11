import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plate_scanner_app/core/styles/style_adm.dart';
import 'package:plate_scanner_app/core/utils/dialogs.dart';
import 'package:plate_scanner_app/features/settings/presentation/widgets/custom_menu_card.dart';

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Permisos',
          style: StyleApp.bigTitleStyleBlanco,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: StyleApp.appColorPrimary,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                children: [
                  CustomMenuCard(
                    icon: Icons.camera_alt_rounded,
                    title: 'Cámara',
                    subtitle: 'Permisos de la Cámara para el Uso de la App',
                    onTap: () async {
                      final status = await Permission.camera.request();

                      if (status.isGranted) {
                        DialogsAdm.msjExito(
                          context: context,
                          mensaje: 'Permiso de cámara concedido',
                          onConfirm: () {},
                        );
                      } else if (status.isPermanentlyDenied) {
                        // Mostrar diálogo para abrir configuración
                        DialogsAdm.mostrarPregunta(
                          context: context,
                          mensaje:
                              'El permiso fue denegado permanentemente. ¿Deseas abrir la configuración para habilitarlo manualmente?',
                          onConfirm: () async {
                            await openAppSettings();
                          },
                          onCancel: () {},
                        );
                      } else {
                        // Mostrar diálogo para reintentar
                        DialogsAdm.mostrarPregunta(
                          context: context,
                          mensaje:
                              'Para usar esta función necesitamos acceso a la cámara. ¿Deseas intentarlo de nuevo?',
                          onConfirm: () {},
                          onCancel: () {},
                        );
                      }
                    },
                  ),
                  CustomMenuCard(
                    icon: Icons.location_pin,
                    title: 'Ubicacion',
                    subtitle:
                        'Permisos de Ubicacion para Obtener Longitud y Latitud',
                    onTap: () async {
                      final status = await Permission.location.request();

                      if (status.isGranted) {
                        DialogsAdm.msjExito(
                          context: context,
                          mensaje: 'Permiso de Ubicacion concedido',
                          onConfirm: () {},
                        );
                      } else if (status.isPermanentlyDenied) {
                        // Mostrar diálogo para abrir configuración
                        DialogsAdm.mostrarPregunta(
                          context: context,
                          mensaje:
                              'El permiso fue denegado permanentemente. ¿Deseas abrir la configuración para habilitarlo manualmente?',
                          onConfirm: () async {
                            await openAppSettings();
                          },
                          onCancel: () {},
                        );
                      } else {
                        // Mostrar diálogo para reintentar
                        DialogsAdm.mostrarPregunta(
                          context: context,
                          mensaje:
                              'Para usar esta función necesitamos acceso a la ubicacion. ¿Deseas intentarlo de nuevo?',
                          onConfirm: () {},
                          onCancel: () {},
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
