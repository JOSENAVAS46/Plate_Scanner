import 'package:flutter/material.dart';
import 'package:plate_scanner_app/core/styles/style_adm.dart';

class CustomIconTextButton extends StatelessWidget {
  final Color backgroundColor;
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool isEnabled;

  const CustomIconTextButton({
    super.key,
    required this.backgroundColor,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isEnabled,
      child: Opacity(
        opacity: isEnabled ? 1.0 : 0.5,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(100),
          ),
          child: TextButton(
            onPressed: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: StyleApp.appColorBlanco,
                ),
                const SizedBox(width: 10),
                Text(
                  label,
                  style: StyleApp.regularTxtStyleBoldBlanco,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
