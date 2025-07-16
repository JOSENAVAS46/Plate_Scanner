import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plate_scanner_app/core/enums/enum.dart';
import 'package:plate_scanner_app/core/styles/style_adm.dart';
import 'package:plate_scanner_app/core/utils/dialogs.dart';
import 'package:plate_scanner_app/core/utils/methods.dart';
import 'package:plate_scanner_app/features/_other/data/models/res_detect_input_model.dart';
import 'package:plate_scanner_app/features/_other/presentation/pages/loading_screen.dart';
import 'package:plate_scanner_app/features/_other/presentation/widgets/separador.dart';
import 'package:plate_scanner_app/features/_other/presentation/widgets/text_field_custom.dart';
import 'package:plate_scanner_app/features/input_plate/presentation/blocs/input_plate_bloc.dart';

class ImagePlateInputPlateScreen extends StatefulWidget {
  final String imagePath;

  const ImagePlateInputPlateScreen({super.key, required this.imagePath});

  @override
  State<ImagePlateInputPlateScreen> createState() =>
      _ImagePlateInputPlateScreenState();
}

class _ImagePlateInputPlateScreenState
    extends State<ImagePlateInputPlateScreen> {
  final TextEditingController _plateController = TextEditingController();
  final FocusNode _plateFocusNode = FocusNode();
  var veh = Vehiculo();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_plateFocusNode);
    });
  }

  @override
  void dispose() {
    _plateController.dispose();
    _plateFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<InputPlateBloc, InputPlateState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        switch (formStatus) {
          case VehiculoRecibidoState():
            veh = formStatus.response.data!.vehiculo!;
            Navigator.pushNamed(
              context,
              '/vehiculo_detail',
              arguments: {
                'imagePath': widget.imagePath,
                'vehiculo': veh,
              },
            );
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
                'Verificar Placa',
                style: StyleApp.bigTitleStyleBlanco,
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: StyleApp.appColorBlanco),
                onPressed: () => Navigator.pop(context),
              ),
              centerTitle: true,
              backgroundColor: StyleApp.appColorPrimary,
            ),
            body: Stack(
              children: [
                Column(
                  children: [
                    SeparadorAltura(size: size, porcentaje: 2),
                    // Image display
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: InteractiveViewer(
                        panEnabled: true,
                        minScale: 0.5,
                        maxScale: 4.0,
                        child: Image.file(
                          File(widget.imagePath),
                          fit: BoxFit.contain,
                          height: size.height * 0.3,
                        ),
                      ),
                    ),
                    SeparadorAltura(size: size, porcentaje: 2),
                    // Plate input field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextFieldCustom(
                        controller: _plateController,
                        focusNode: _plateFocusNode,
                        isCentered: true,
                        label: 'Placa',
                        hint: 'ABC123 - ABC1234 - AB123C',
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
                    SeparadorAltura(size: size, porcentaje: 2),
                    // Vehicle details if available
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
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: Column(
                    children: [
                      FloatingActionButton(
                        heroTag: 'clean_btn_${widget.imagePath}',
                        onPressed: () {
                          setState(() {
                            veh = Vehiculo();
                            _plateController.clear();
                            _plateFocusNode.requestFocus();
                          });
                        },
                        backgroundColor: StyleApp.appColorPrimary,
                        child: Icon(Icons.clear_rounded,
                            color: StyleApp.appColorBlanco),
                      ),
                      SeparadorAltura(size: size, porcentaje: 2),
                      FloatingActionButton(
                        heroTag: 'search_btn_${widget.imagePath}',
                        onPressed: () {
                          if (_plateController.text.isNotEmpty) {
                            context.read<InputPlateBloc>().add(
                                SendInputPlateEvent(
                                    plate: _plateController.text.trim()));
                          } else {
                            DialogsAdm.msjError(
                              context: context,
                              mensaje:
                                  'La placa es requerida para buscar el vehículo.',
                            );
                          }
                        },
                        backgroundColor: StyleApp.appColorPrimary,
                        child: Icon(Icons.search_rounded,
                            color: StyleApp.appColorBlanco),
                      ),
                    ],
                  ),
                ),
              ],
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
