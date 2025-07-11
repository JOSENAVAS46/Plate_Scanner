import 'package:flutter/material.dart';
import 'package:plate_scanner_app/core/styles/style_adm.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Historial',
          style: StyleApp.bigTitleStyleBlanco,
        ),
        centerTitle: true,
        backgroundColor: StyleApp.appColorPrimary,
      ),
      body: SafeArea(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
