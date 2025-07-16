import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plate_scanner_app/core/styles/style_adm.dart';

class TextFieldCustom extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode; // Cambiado a parámetro opcional
  final String label;
  final String hint;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final int? maxLength;
  final String? Function(String?)? customValidator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final bool isCentered;
  final bool autofocus; // Nuevo parámetro para autofocus

  const TextFieldCustom({
    super.key, // Agregado key
    required this.controller,
    this.focusNode, // Ahora es opcional
    required this.label,
    required this.hint,
    this.onChanged,
    this.onFieldSubmitted,
    this.maxLength,
    this.customValidator,
    this.inputFormatters,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.isCentered = false,
    this.autofocus = false, // Valor por defecto false
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode, // Usamos el focusNode proporcionado o null
      autofocus: autofocus, // Usamos el parámetro autofocus
      validator: customValidator ?? _defaultValidator,
      textAlign: isCentered ? TextAlign.center : TextAlign.start,
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
