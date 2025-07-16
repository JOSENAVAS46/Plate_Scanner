import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:plate_scanner_app/core/styles/style_adm.dart';
import 'package:plate_scanner_app/core/utils/dialogs.dart';
import 'package:plate_scanner_app/features/_other/presentation/widgets/separador.dart';
import 'package:plate_scanner_app/features/identification/presentation/pages/image_viewer_screen.dart';

class IdentificationScreen extends StatefulWidget {
  const IdentificationScreen({super.key});

  @override
  State<IdentificationScreen> createState() => _IdentificationScreenState();
}

class _IdentificationScreenState extends State<IdentificationScreen>
    with WidgetsBindingObserver {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final firstCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      _controller = CameraController(
        firstCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      _initializeControllerFuture = _controller!.initialize().then((_) {
        if (mounted) {
          setState(() => _isCameraInitialized = true);
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}',
              style: StyleApp.regularTxtStyleBlanco),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<String> _saveImageToGallery(String imagePath) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String newPath =
        '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
    await File(imagePath).copy(newPath);
    return newPath;
  }

  Future<void> _captureImage() async {
    try {
      if (!_controller!.value.isInitialized) {
        return;
      }

      final image = await _controller!.takePicture();
      final savedPath = await _saveImageToGallery(image.path);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageViewerScreen(imagePath: savedPath),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al capturar imagen: ${e.toString()}',
              style: StyleApp.regularTxtStyleBlanco),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile == null) return;

      final savedPath = await _saveImageToGallery(pickedFile.path);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageViewerScreen(imagePath: savedPath),
        ),
      );
    } catch (e) {
      DialogsAdm.msjError(
          context: context,
          mensaje: 'Error al seleccionar imagen: ${e.toString()}',
          onConfirm: () {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: StyleApp.appColorPlomo,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: StyleApp.appColorBlanco),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Captura de Imagen',
            style: StyleApp.bigTitleStyleBlanco,
          ),
          centerTitle: true,
          backgroundColor: StyleApp.appColorPrimary,
        ),
        body: _controller == null || !_isCameraInitialized
            ? Center(
                child:
                    CircularProgressIndicator(color: StyleApp.appColorPrimary))
            : Stack(
                children: [
                  // Vista de la cámara sin aspect ratio
                  Positioned.fill(
                    child: CameraPreview(_controller!),
                  ),
                  Positioned(
                    right: 16,
                    bottom: 16,
                    child: Column(
                      children: [
                        FloatingActionButton(
                          heroTag: 'upload_btn',
                          onPressed: _pickImageFromGallery,
                          backgroundColor: StyleApp.appColorPrimary,
                          child: Icon(Icons.upload_rounded,
                              color: StyleApp.appColorBlanco),
                        ),
                        SeparadorAltura(size: size, porcentaje: 2),
                        FloatingActionButton(
                          heroTag: 'capture_btn',
                          onPressed: _captureImage,
                          backgroundColor: StyleApp.appColorPrimary,
                          child: Icon(Icons.camera,
                              color: StyleApp.appColorBlanco),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
