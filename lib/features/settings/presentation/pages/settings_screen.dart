import 'package:flutter/material.dart';
import 'package:plate_scanner_app/core/mocks/app_info.dart';
import 'package:plate_scanner_app/core/styles/style_adm.dart';
import 'package:plate_scanner_app/core/utils/methods.dart';
import 'package:plate_scanner_app/features/_other/data/models/usuario_model.dart';
import 'package:plate_scanner_app/features/settings/presentation/widgets/custom_menu_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _cameraQuality = 'Alta'; // Can be 'Low', 'Medium', 'High'

  void _navigateToPermissions() {
    Navigator.pushNamedAndRemoveUntil(context, '/permissions', (route) => true);
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Acerca de',
          style: StyleApp.mediumTitleStyleBlancoBold,
        ),
        backgroundColor: StyleApp.appColorPrimary,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppInfo().appName,
              style: StyleApp.regularTxtStyleBlanco,
            ),
            const SizedBox(height: 8),
            Text(
              'Versión: ${AppInfo().version}',
              style: StyleApp.regularTxtStyleBlanco,
            ),
            const SizedBox(height: 8),
            Text(
              'Desarrolladores: \n${AppInfo().developers.join(', ')}',
              style: StyleApp.regularTxtStyleBlanco,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cerrar',
              style: StyleApp.regularTxtStyleBlanco,
            ),
          ),
        ],
      ),
    );
  }

  void _showDeviceDialog() async {
    UsuarioModel device = await getDeviceInfo();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Información del Dispositivo',
          style: StyleApp.mediumTitleStyleBlancoBold,
        ),
        backgroundColor: StyleApp.appColorPrimary,
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Información del dispositivo
              _buildDeviceInfoRow(
                  'ID del dispositivo', device.deviceId ?? 'No disponible'),
              _buildDeviceInfoRow(
                  'Marca', device.deviceBrand ?? 'No disponible'),
              _buildDeviceInfoRow(
                  'Modelo', device.deviceModel ?? 'No disponible'),
              _buildDeviceInfoRow(
                  'Nombre', device.deviceName ?? 'No disponible'),
              _buildDeviceInfoRow(
                  'Número de serie', device.serialNumber ?? 'No disponible'),
              _buildDeviceInfoRow(
                  'Estado', device.activo == true ? 'Activo' : 'Inactivo'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cerrar',
              style: StyleApp.regularTxtStyleBlanco,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: RichText(
        text: TextSpan(
          style: StyleApp.regularTxtStyleBlanco,
          children: [
            TextSpan(
              text: '$label: ',
              style: StyleApp.regularTxtStyleBoldBlanco,
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ajustes',
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
                    icon: Icons.notifications,
                    title: 'Permisos',
                    subtitle: 'Permisos de uso de la app',
                    onTap: _navigateToPermissions,
                  ),
                  CustomMenuCard(
                    icon: Icons.info,
                    title: 'Acerca de',
                    onTap: _showAboutDialog,
                  ),
                  CustomMenuCard(
                    icon: Icons.system_security_update_good_rounded,
                    title: 'Informacion del Dispositivo',
                    onTap: _showDeviceDialog,
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
