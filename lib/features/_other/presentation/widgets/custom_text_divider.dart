import 'package:flutter/material.dart';
import 'package:plate_scanner_app/features/_other/presentation/widgets/separador.dart';

class CustomTextDivider extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final bool secondary;

  const CustomTextDivider({
    required this.text,
    this.textStyle = const TextStyle(
      fontSize: 17,
      color: Color(0xFF000000),
    ),
    this.secondary = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final adjustedTextStyle = secondary
        ? textStyle.copyWith(fontSize: textStyle.fontSize! * 0.8)
        : textStyle;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SeparadorAltura(size: size, porcentaje: 1),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              text,
              textAlign: TextAlign.left,
              style: adjustedTextStyle,
            ),
          ],
        ),
        Divider(),
        SeparadorAltura(size: size, porcentaje: 1)
      ],
    );
    ;
  }
}
