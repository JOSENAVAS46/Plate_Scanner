import 'package:flutter/material.dart';
import 'package:plate_scanner_app/core/mocks/app_info.dart';
import 'package:plate_scanner_app/core/styles/style_adm.dart';
import 'package:plate_scanner_app/features/home/domain/entities/menu_options_entitie.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final List<MenuOptionsEntitie> optionList = [
    MenuOptionsEntitie(
      title: 'Identificar Placa',
      icon: Icons.directions_car,
      onTap: () => _navigateToPlateIdentification(),
    ),
    MenuOptionsEntitie(
      title: 'Ingresar Placa',
      icon: Icons.stay_primary_landscape_rounded,
      onTap: () => _navigateToPlateInputPlate(),
    ),
    MenuOptionsEntitie(
      title: 'Reportes',
      icon: Icons.assignment,
      onTap: () => _navigateToReports(),
    ),
    MenuOptionsEntitie(
      title: 'Historial',
      icon: Icons.history,
      onTap: () => _navigateToHistory(),
    ),
    MenuOptionsEntitie(
      title: 'Ajustes',
      icon: Icons.settings,
      onTap: () => _navigateToSettings(),
    ),
  ];

  void _navigateToPlateIdentification() {
    Navigator.pushNamedAndRemoveUntil(
        context, '/identification', (route) => true);
  }

  void _navigateToHistory() {
    Navigator.pushNamedAndRemoveUntil(context, '/history', (route) => true);
  }

  void _navigateToPlateInputPlate() {
    Navigator.pushNamedAndRemoveUntil(context, '/input_plate', (route) => true);
  }

  void _navigateToReports() {
    Navigator.pushNamedAndRemoveUntil(context, '/reports', (route) => true);
  }

  void _navigateToSettings() {
    Navigator.pushNamedAndRemoveUntil(context, '/settings', (route) => true);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppInfo().appName,
          style: StyleApp.bigTitleStyleBlanco,
        ),
        centerTitle: true,
        backgroundColor: StyleApp.appColorPrimary,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: optionList.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 1,
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                ),
                itemBuilder: (context, index) {
                  final option = optionList[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Icon(
                        option.icon,
                        color: StyleApp.appColorBlanco,
                        size: 28,
                      ),
                      title: Text(
                        option.title,
                        style: StyleApp.mediumTitleStyleBlancoBold,
                      ),
                      trailing: Icon(Icons.chevron_right,
                          color: StyleApp.appColorBlanco, size: 28),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      onTap: option.onTap,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
