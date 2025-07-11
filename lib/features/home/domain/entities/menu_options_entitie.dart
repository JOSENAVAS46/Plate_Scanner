import 'package:flutter/material.dart';

class MenuOptionsEntitie {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  MenuOptionsEntitie({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}
