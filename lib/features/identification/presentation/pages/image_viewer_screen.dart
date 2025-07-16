import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plate_scanner_app/core/enums/enum.dart';
import 'package:plate_scanner_app/core/styles/style_adm.dart';
import 'package:plate_scanner_app/core/utils/dialogs.dart';
import 'package:plate_scanner_app/features/_other/presentation/pages/loading_screen.dart';
import 'package:plate_scanner_app/features/_other/presentation/widgets/custom_elevated_button.dart';
import 'package:plate_scanner_app/features/_other/presentation/widgets/separador.dart';
import 'package:plate_scanner_app/features/identification/presentation/blocs/identification_bloc.dart';

class ImageViewerScreen extends StatefulWidget {
  final String imagePath;

  const ImageViewerScreen({super.key, required this.imagePath});

  @override
  State<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<IdentificationBloc, IdentificationState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        switch (formStatus) {
          case DeteccionRecibidaState():
            Navigator.pushNamed(
              context,
              '/vehiculo_detail',
              arguments: {
                'imagePath': widget.imagePath,
                'vehiculo': formStatus.response.data!.vehiculo!,
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
              case TipoMensajeBloc.question:
                if (formStatus.mensaje
                    .contains("No se pudo reconocer la placa")) {
                  DialogsAdm.mostrarPregunta(
                    context: context,
                    mensaje: formStatus.mensaje,
                    onConfirm: () {
                      // Navegar a la pantalla de ingreso manual con la imagen
                      Navigator.pushNamed(
                        context,
                        '/input_plate_with_image',
                        arguments: {
                          'imagePath': widget.imagePath,
                        },
                      );
                    },
                    onCancel: () {
                      Navigator.pop(context); // Volver atrás si cancela
                    },
                  );
                } else {
                  // Manejar otros tipos de preguntas
                  DialogsAdm.mostrarPregunta(
                    context: context,
                    mensaje: formStatus.mensaje,
                    onConfirm: () {},
                    onCancel: () {},
                  );
                }
                break;
              default:
                DialogsAdm.msjSistema(
                    context: context, mensaje: formStatus.mensaje);
            }
        }
      },
      child: BlocBuilder<IdentificationBloc, IdentificationState>(
        builder: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is LoadingState) {
            return LoadingScreen(mensaje: formStatus.mensaje);
          }
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: StyleApp.appColorBlanco),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                'Visualizacion de Foto',
                style: StyleApp.bigTitleStyleBlanco,
              ),
              centerTitle: true,
              backgroundColor: StyleApp.appColorPrimary,
            ),
            body: Column(
              children: [
                SeparadorAltura(size: size, porcentaje: 2),
                Text(
                  '¿La foto es correcta?',
                  style: StyleApp.regularTxtStyleBoldBlanco,
                ),
                SeparadorAltura(size: size, porcentaje: 2),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InteractiveViewer(
                      panEnabled: true,
                      minScale: 0.5,
                      maxScale: 4.0,
                      child: Container(
                        constraints: BoxConstraints(
                          maxHeight: size.height, // Limita la altura máxima
                        ),
                        child: Image.file(
                          File(widget.imagePath),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                SeparadorAltura(size: size, porcentaje: 2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: CustomElevatedButton(
                            isPrimary: false,
                            text: 'No',
                            onPressed: () {
                              Navigator.pop(context, false);
                            }),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      Expanded(
                        flex: 4,
                        child: CustomElevatedButton(
                            text: 'Si',
                            onPressed: () {
                              context.read<IdentificationBloc>().add(
                                    SendImgBytesEvent(
                                        imagePath: widget.imagePath),
                                  );
                            }),
                      ),
                    ],
                  ),
                ),
                SeparadorAltura(size: size, porcentaje: 5),
              ],
            ),
          );
        },
      ),
    );
  }
}
