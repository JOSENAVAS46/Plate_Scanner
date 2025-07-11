import 'package:flutter/material.dart';
import 'package:plate_scanner_app/core/styles/style_adm.dart';

class ReadOnlyTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  const ReadOnlyTextFieldWidget({
    required this.controller,
    required this.label,
    required this.hint,
    this.onChanged,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return '$label Requerido';
        }
        return null;
      },
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      readOnly: true,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: StyleApp.regularTxtStyleBold.copyWith(
          color: StyleApp.appColorPlomo,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    ;
  }
}
