import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plate_scanner_app/core/enums/enum.dart';
import 'package:plate_scanner_app/core/styles/style_adm.dart';
import 'package:plate_scanner_app/core/utils/dialogs.dart';
import 'package:plate_scanner_app/core/utils/methods.dart';
import 'package:plate_scanner_app/features/_other/data/models/res_detect_input_model.dart';
import 'package:plate_scanner_app/features/_other/presentation/pages/loading_screen.dart';
import 'package:plate_scanner_app/features/_other/presentation/widgets/custom_elevated_button.dart';
import 'package:plate_scanner_app/features/_other/presentation/widgets/separador.dart';
import 'package:plate_scanner_app/features/_other/presentation/widgets/text_field_custom.dart';
import 'package:plate_scanner_app/features/input_plate/presentation/blocs/input_plate_bloc.dart';

class InputPlateScreen extends StatefulWidget {
  const InputPlateScreen({super.key});

  @override
  State<InputPlateScreen> createState() => _InputPlateScreenState();
}

class _InputPlateScreenState extends State<InputPlateScreen> {
  final TextEditingController controller = TextEditingController();
  var veh = new Vehiculo();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<InputPlateBloc, InputPlateState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        switch (formStatus) {
          case VehiculoRecibidoState():
            veh = formStatus.response.data!.vehiculo!;
            break;
          case MessageState():
            final tipo = formStatus.tipo;
            switch (tipo) {
              case TipoMensajeBloc.error:
                DialogsAdm.msjError(
                    context: context, mensaje: formStatus.mensaje);
                break;
              case TipoMensajeBloc.success:
                DialogsAdm.msjExito(
                    context: context, mensaje: formStatus.mensaje);
                break;
              default:
                DialogsAdm.msjSistema(
                    context: context, mensaje: formStatus.mensaje);
            }
        }
      },
      child: BlocBuilder<InputPlateBloc, InputPlateState>(
        builder: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is LoadingState) {
            return LoadingScreen(mensaje: formStatus.mensaje);
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Ingresar Placa',
                style: StyleApp.bigTitleStyleBlanco,
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              centerTitle: true,
              backgroundColor: StyleApp.appColorPrimary,
            ),
            body: SafeArea(
              child: Column(
                children: [
                  SeparadorAltura(size: size, porcentaje: 4),
                  Row(
                    children: [
                      SeparadorAncho(size: size, porcentaje: 4),
                      Expanded(
                        child: TextFieldCustom(
                          controller: controller,
                          label: 'Placa',
                          hint: 'ABC1234',
                          maxLength: 7,
                          textCapitalization: TextCapitalization.characters,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[A-Z0-9]')),
                            UpperCaseTextFormatter(),
                          ],
                          customValidator: (value) {
                            if (value == null || value.isEmpty)
                              return 'Placa requerida';
                            if (value.length != 7)
                              return 'Debe tener 7 caracteres';
                            if (!RegExp(r'^[A-Z0-9]{7}$').hasMatch(value)) {
                              return 'Solo letras mayúsculas y números';
                            }
                            return null;
                          },
                        ),
                      ),
                      SeparadorAncho(size: size, porcentaje: 4),
                    ],
                  ),
                  SeparadorAltura(size: size, porcentaje: 2),
                  Row(
                    children: [
                      SeparadorAncho(size: size, porcentaje: 4),
                      Expanded(
                        child: CustomElevatedButton(
                            text: 'Buscar',
                            onPressed: () {
                              veh = Vehiculo();
                              context.read<InputPlateBloc>().add(
                                  SendInputPlateEvent(
                                      plate: controller.text.trim()));
                            }),
                      ),
                      SeparadorAncho(size: size, porcentaje: 4),
                    ],
                  ),
                  SeparadorAltura(size: size, porcentaje: 2),
                  if (veh.placa != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Card(
                        color: StyleApp.appColorBlanco,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: StyleApp.appColorPrimary,
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildDetailRow('Placa:', veh.placa ?? 'N/A'),
                              SeparadorAltura(size: size, porcentaje: 1),
                              _buildDetailRow('Marca:', veh.marca ?? 'N/A'),
                              SeparadorAltura(size: size, porcentaje: 1),
                              _buildDetailRow('Modelo:', veh.modelo ?? 'N/A'),
                              SeparadorAltura(size: size, porcentaje: 1),
                              _buildDetailRow('Color:', veh.color ?? 'N/A'),
                              SeparadorAltura(size: size, porcentaje: 1),
                              _buildDetailRow(
                                  'Año:', veh.anio?.toString() ?? 'N/A'),
                              SeparadorAltura(size: size, porcentaje: 1),
                              _buildDetailRow('Clase:', veh.clase ?? 'N/A'),
                              SeparadorAltura(size: size, porcentaje: 1),
                              _buildDetailRow(
                                  'Servicio:', veh.servicio ?? 'N/A'),
                              SeparadorAltura(size: size, porcentaje: 1),
                              _buildDetailRow(
                                  'Fecha Mat:', veh.fechaMatricula ?? 'N/A'),
                              SeparadorAltura(size: size, porcentaje: 1),
                              _buildDetailRow(
                                  'Fecha Cad:', veh.fechaCaducidad ?? 'N/A'),
                              SeparadorAltura(size: size, porcentaje: 1),
                              _buildDetailRow(
                                  'Polarizado:', veh.polarizado ?? 'N/A'),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: StyleApp.regularTxtStyleBold,
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            value,
            style: StyleApp.regularTxtStyle,
          ),
        ),
      ],
    );
  }
}
