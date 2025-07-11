import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:plate_scanner_app/core/utils/ftp_handler.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class FileHandler {
  final String ftpPdfDir = '/operaciones/pdfs';
  Future<Directory> getExternalStorageDir() async {
    final dir = await path_provider.getExternalStorageDirectories();
    print('Dir: ${dir.toString()}');
    return dir!.first;
  }

  Future<File?> saveFirmaImage({
    required String fileName,
    required Uint8List imageBytes,
  }) async {
    try {
      final dir = await getExternalStorageDir();
      final firmasDir = Directory('${dir.path}/firmas');
      if (!await firmasDir.exists()) {
        await firmasDir.create(recursive: true);
        print('Directorio "firmas" creado!');
      }
      final file = File('${firmasDir.path}/$fileName');
      await file.writeAsBytes(imageBytes);
      print('Imagen guardada en: ${file.path}');
      return file;
    } catch (e) {
      print('Error al guardar la imagen: $e');
      return null;
    }
  }

  Future<void> cleanDirectory({required Directory directory}) async {
    try {
      if (await directory.exists()) {
        await for (var entity in directory.list(recursive: false)) {
          if (entity is File) {
            await entity.delete();
          } else if (entity is Directory) {
            await entity.delete(recursive: true);
          }
        }
        print("El directorio '${directory.path}' ha sido limpiado.");
      } else {
        print("El directorio '${directory.path}' no existe.");
      }
    } catch (e) {
      print("Error al limpiar el directorio ${directory.path}': $e");
    }
  }

  Future<bool> deleteFile(String filePath) async {
    final file = File(filePath);
    await file.delete();
    return true;
  }

  Future<bool> isFileAvailableLocally(String filePath) async {
    final file = File(filePath);
    return await file.exists();
  }

/*
  Future<String> getFtpPathPdf(String pdfName) async {

    final parametros = await CrudParametros().getFirstParametro();
    final servidorFtp = parametros.servidorFtp;
    return 'ftp://$servidorFtp$ftpPdfDir/$pdfName';


  }
     */
  void createDefaultDirectories() async {
    await path_provider.getExternalStorageDirectories().then((dir) {
      final directorioFotosLocal = Directory('${dir!.first.path}/fotos');
      final directorioPdfLocal = Directory('${dir.first.path}/pdfs');
      final directorioChoferLocal = Directory('${dir.first.path}/chofer');
      if (!directorioFotosLocal.existsSync()) {
        directorioFotosLocal.createSync(recursive: true);
      }
      if (!directorioPdfLocal.existsSync()) {
        directorioPdfLocal.createSync(recursive: true);
      }
      if (!directorioChoferLocal.existsSync()) {
        directorioChoferLocal.createSync(recursive: true);
      }
    });
  }

  Future<void> limpiarDirectorioFotos() async {
    final dir = await path_provider.getExternalStorageDirectories();
    final directorioFotosLocal = Directory('${dir!.first.path}/fotos');
    if (directorioFotosLocal.existsSync()) {
      await cleanDirectory(directory: directorioFotosLocal);
    }
  }

  Future<List<File>> getFiles() async {
    final Directory directory = Directory(
        '/storage/emulated/0/Android/data/com.birobid.admoperaciones/files/pdfs');
    if (directory.existsSync()) {
      return directory.listSync().map((e) => File(e.path)).toList();
    } else {
      return [];
    }
  }

  File obtenerImagenLocalmente(String ftpUrl) {
    final path = FtpHandler().extractPathFromFTPUrl(ftpUrl);
    final pathSplit = path.split('/');
    final nombreArchivo = pathSplit.last;
    final directorio =
        ('${path_provider.getExternalStorageDirectories().then((dir) {
      return dir!.first.path;
    })}/fotos');
    final file = File('$directorio/$nombreArchivo');
    return file;
  }

  Future<File?> saveFotosInBytes({
    required String fileName,
    required Uint8List imageBytes,
  }) async {
    final folderName = '/fotos';
    try {
      final dir = await path_provider.getExternalStorageDirectories();
      final phothosDir = Directory('${dir!.first.path}$folderName');
      if (!await phothosDir.exists()) {
        await phothosDir.create(recursive: true);
        print('Directorio "$folderName" creado!');
      }
      final file = File('${phothosDir.path}/$fileName');
      await file.writeAsBytes(imageBytes);
      print('Imagen guardada en: ${file.path}');
      return file;
    } catch (e) {
      print('Error al guardar la imagen: $e');
      return null;
    }
  }

  Future<String> savePictureOperacion(
      XFile file, String tipo, String subtipo) async {
    final fotosPath = 'fotos';
    final base =
        (await path_provider.getExternalStorageDirectories())!.first.path;
    final directoryPath = join(base, fotosPath);
    final String newPath =
        '${directoryPath}/${tipo}_${subtipo}_${DateTime.now().millisecondsSinceEpoch}.jpg';

    // Verificar si el archivo ya existe
    final File newImage = File(newPath);
    if (await newImage.exists()) {
      // Si existe, lo borramos
      await newImage.delete();
    }

    // Copiar el nuevo archivo
    final File savedImage = await File(file.path).copy(newPath);
    return savedImage.path;
  }

  Future<String> saveImage(Uint8List imageBytes,
      {String fileName = 'imag e.jpg'}) async {
    // Obtener el directorio temporal
    final tempDir = await path_provider.getTemporaryDirectory();

    // Crear un archivo temporal con el nombre dado
    final file = File('${tempDir.path}/$fileName');

    // Guardar el Uint8List en el archivo
    await file.writeAsBytes(imageBytes);

    // Devolver la ruta del archivo
    return file.path;
  }
}
