import 'package:flutter/material.dart';
import 'package:plate_scanner_app/core/styles/style_adm.dart';
import 'package:plate_scanner_app/features/_other/presentation/widgets/read_only_text_field.dart';
import 'package:plate_scanner_app/features/_other/presentation/widgets/separador.dart';

class CustomGenericBoxWidget extends StatefulWidget {
  final TextEditingController codigoController;
  final TextEditingController nombreController;
  final String codigoLabel;
  final String nombreLabel;
  final Size size;
  final VoidCallback onCodeTap;

  const CustomGenericBoxWidget({
    Key? key,
    required this.codigoController,
    required this.nombreController,
    required this.codigoLabel,
    required this.nombreLabel,
    required this.onCodeTap,
    required this.size,
  }) : super(key: key);

  @override
  State<CustomGenericBoxWidget> createState() => _CustomGenericBoxWidgetState();
}

class _CustomGenericBoxWidgetState extends State<CustomGenericBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SeparadorAltura(size: widget.size, porcentaje: 2),
        Row(
          children: <Widget>[
            SeparadorAncho(size: widget.size, porcentaje: 2),
            Expanded(
              flex: 3,
              child: Container(
                child: TextFormField(
                  controller: widget.codigoController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: widget.codigoLabel,
                    hintText: '',
                    labelStyle: StyleApp.regularTxtStyleBold.copyWith(
                      color: StyleApp.appColorPrimary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: StyleApp.appColorPlomo,
                      ),
                    ),
                  ),
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    widget.onCodeTap();
                    setState(() {});
                  },
                ),
              ),
            ),
            SeparadorAncho(size: widget.size, porcentaje: 2),
            Expanded(
              flex: 7,
              child: Container(
                child: ReadOnlyTextFieldWidget(
                  controller: widget.nombreController,
                  label: widget.nombreLabel,
                  hint: '',
                ),
              ),
            ),
            SeparadorAncho(size: widget.size, porcentaje: 2),
          ],
        ),
        SeparadorAltura(size: widget.size, porcentaje: 2),
      ],
    );
  }
}
