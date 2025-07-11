import 'package:flutter/material.dart';
import 'package:plate_scanner_app/core/styles/style_adm.dart';
import 'package:plate_scanner_app/core/utils/methods.dart';

class CustomDropdownButton extends StatelessWidget {
  final String? value;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String?> onChanged;
  final bool isPrimary;

  const CustomDropdownButton({
    Key? key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.isPrimary = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: calcularHeight(size, 6),
      decoration: BoxDecoration(
        color: isPrimary ? StyleApp.appColorPrimary : StyleApp.appColorBlanco,
        borderRadius: BorderRadius.circular(10),
        border: isPrimary ? null : Border.all(color: StyleApp.appColorPrimary),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: DropdownButton<String>(
          borderRadius: BorderRadius.circular(10),
          style: isPrimary
              ? StyleApp.regularTxtStyleBlanco
              : StyleApp.regularTxtStyleBlanco
                  .copyWith(color: StyleApp.appColorNegro),
          isExpanded: true,
          value: value,
          items: items,
          onChanged: onChanged,
          underline: Container(),
          icon: Icon(
            Icons.arrow_drop_down,
            color:
                isPrimary ? StyleApp.appColorBlanco : StyleApp.appColorPrimary,
          ),
          dropdownColor:
              isPrimary ? StyleApp.appColorPrimary : StyleApp.appColorBlanco,
        ),
      ),
    );
  }
}
