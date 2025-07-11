import 'package:flutter/material.dart';
import 'package:plate_scanner_app/core/styles/style_adm.dart';

class DecimalInputField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final void Function(double?)? onChanged;
  final bool readOnly;
  final bool allowZero; // Nueva variable opcional

  const DecimalInputField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.hintText = '',
    this.onChanged,
    this.readOnly = false,
    this.allowZero = true, // Por defecto permite 0
  }) : super(key: key);

  @override
  State<DecimalInputField> createState() => _DecimalInputFieldState();
}

class _DecimalInputFieldState extends State<DecimalInputField> {
  @override
  void initState() {
    super.initState();
    if (widget.controller.text.isEmpty) {
      widget.controller.text = '0'; // Inicializar con 0 si está vacío
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        if (widget.readOnly == false) {
          widget.controller.clear();
          FocusScope.of(context).requestFocus(FocusNode());
        }
      },
      child: TextFormField(
        controller: widget.controller,
        readOnly: widget.readOnly,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          labelStyle: StyleApp.regularTxtStyleBold.copyWith(
            color: !widget.readOnly
                ? StyleApp.appColorPrimary
                : StyleApp.appColorPlomo,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: StyleApp.appColorPlomo,
            ),
          ),
        ),
        keyboardType: widget.readOnly
            ? null
            : const TextInputType.numberWithOptions(decimal: true),
        onTap: () {
          // Limpiar el 0 al enfocar
          if (widget.controller.text == '0') {
            widget.controller.clear();
          }
        },
        onChanged: widget.readOnly
            ? null
            : (value) {
                // Reemplazar comas con puntos
                String correctedValue = value.replaceAll(',', '.');

                // Eliminar ceros iniciales innecesarios (excepto para valores decimales como "0.x")
                if (correctedValue.startsWith('0') &&
                    correctedValue.length > 1 &&
                    !correctedValue.startsWith('0.')) {
                  correctedValue = correctedValue.substring(1);
                }

                // Asegurar que solo hay un punto decimal
                int dotCount = '.'.allMatches(correctedValue).length;
                if (dotCount > 1) {
                  // Si hay más de un punto, eliminar el último ingresado
                  correctedValue =
                      correctedValue.substring(0, correctedValue.length - 1);
                }

                // Si el campo queda vacío, asignar "0"
                if (correctedValue.isEmpty) {
                  correctedValue = '0';
                }

                // Actualizar el controlador si el valor cambia
                if (correctedValue != value) {
                  widget.controller.value = TextEditingValue(
                    text: correctedValue,
                    selection: TextSelection.fromPosition(
                      TextPosition(offset: correctedValue.length),
                    ),
                  );
                }

                // Llamar al callback `onChanged` si está definido
                if (widget.onChanged != null) {
                  final doubleValue = double.tryParse(correctedValue);
                  widget.onChanged!(doubleValue);
                }
              },
        validator: widget.readOnly
            ? null
            : (value) {
                if (value == null || value.isEmpty) {
                  return 'Este campo no puede estar vacío';
                }
                final correctedValue = value.replaceAll(',', '.');
                final doubleValue = double.tryParse(correctedValue);

                if (doubleValue == null) {
                  return 'Por favor ingresa un número válido';
                }
                if (!widget.allowZero && doubleValue == 0) {
                  return 'El valor no puede ser 0';
                }
                return null;
              },
      ),
    );
  }
}
