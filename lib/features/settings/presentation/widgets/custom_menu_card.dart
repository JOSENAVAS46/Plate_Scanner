import 'package:flutter/material.dart';
import 'package:plate_scanner_app/core/styles/style_adm.dart';

class CustomMenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const CustomMenuCard(
      {super.key,
      required this.icon,
      required this.title,
      this.subtitle,
      this.trailing,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        leading: Icon(
          icon,
          color: StyleApp.appColorBlanco,
          size: 28,
        ),
        title: Text(
          title,
          style: StyleApp.mediumTitleStyleBlancoBold,
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: StyleApp.regularTxtStyleBlanco,
              )
            : null,
        trailing: trailing ??
            (onTap != null
                ? Icon(
                    Icons.chevron_right,
                    color: StyleApp.appColorBlanco,
                    size: 28,
                  )
                : null),
        onTap: onTap,
      ),
    );
  }
}
