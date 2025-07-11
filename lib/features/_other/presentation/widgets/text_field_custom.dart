import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plate_scanner_app/core/styles/style_adm.dart';

class TextFieldCustom extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final int? maxLength;
  final String? Function(String?)? customValidator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;

  const TextFieldCustom({
    required this.controller,
    required this.label,
    required this.hint,
    this.onChanged,
    this.onFieldSubmitted,
    this.maxLength,
    this.customValidator,
    this.inputFormatters,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: customValidator ?? _defaultValidator,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      controller: controller,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        counterText: '',
        labelStyle: StyleApp.regularTxtStyleBoldBlanco,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '$label es requerido';
    }
    return null;
  }
}
