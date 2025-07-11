import 'package:flutter/material.dart';
import 'package:plate_scanner_app/features/_other/presentation/widgets/separador.dart';

class CustomTextIconDividerWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final double iconSize;
  final TextStyle textStyle;
  final bool secondary;
  final bool hasExtra;
  final Widget? extra;

  const CustomTextIconDividerWidget({
    required this.icon,
    required this.text,
    this.iconSize = 18.0,
    this.textStyle = const TextStyle(
      fontSize: 17,
      color: Color(0xFF000000),
    ),
    this.secondary = false,
    this.hasExtra = false,
    this.extra,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final adjustedIconSize = secondary ? iconSize * 0.8 : iconSize;
    final adjustedTextStyle = secondary
        ? textStyle.copyWith(fontSize: textStyle.fontSize! * 0.8)
        : textStyle;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SeparadorAncho(size: size, porcentaje: 5),
                Icon(
                  icon,
                  size: adjustedIconSize,
                ),
                SeparadorAncho(size: size, porcentaje: 5),
                Text(
                  text,
                  style: adjustedTextStyle,
                ),
              ],
            ),
            if (hasExtra)
              Row(
                children: [
                  extra!,
                  SeparadorAncho(size: size, porcentaje: 5),
                ],
              )
          ],
        ),
        SeparadorAltura(size: size, porcentaje: 1)
      ],
    );
    ;
  }
}
