import 'dart:io';

import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List?> validateImage(String path) async {
  print(path);
  File file = File(path);
  if (file.existsSync()) {
    List<int> bytes = await file.readAsBytes();
    Uint8List image = Uint8List.fromList(bytes);

    return image;
  }
  print("No existe la imagen ${basename(path)}");
  return null;
}

class PdfGenerate {
  static Future<File> saveDocument(
      {required String fileName, required pw.Document pdf}) async {
    final bytes = await pdf.save();
    final dirs = await getExternalStorageDirectories();
    print('Dir: ${dirs.toString()}');
    // Directorio por defecto de la app
    final appDir = dirs!.first.path;
    // Buscar la tarjeta SD
    String? sdCardDir;
    if (dirs.length > 1) {
      sdCardDir = dirs[1].path;
    }
    // Definir la ruta de almacenamiento
    /*
    final String folderPath = sdCardDir != null
        ? '$sdCardDir/pdfs' // Si hay tarjeta SD, guarda allí
        : '$appDir/pdfs'; // Si no, guarda en la carpeta de la app

     */
    final String folderPath = '$appDir/pdfs';
    Directory folder;
    folder = Directory(folderPath);
    if (!await folder.exists()) {
      await folder.create(recursive: true);
    }
    final file = File('${folder.path}/$fileName');
    await file.writeAsBytes(bytes);
    print(file.path);
    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }

  static pw.TableRow _buildSimpleTableRow(String title) {
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(1),
          child: pw.Text(
            title,
            style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
            textAlign: pw.TextAlign.center,
          ),
        ),
      ],
    );
  }

  static pw.TableRow _buildDoubleTableRow(
      String titleIzq, String valueIzq, String titleDer, String valueDer) {
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(1),
          child: pw.Text(
            titleIzq,
            style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
            maxLines: 2,
            overflow: pw.TextOverflow.visible,
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(1),
          child: pw.Text(
            valueIzq,
            style: pw.TextStyle(fontSize: 10),
            maxLines: 2,
            overflow: pw.TextOverflow.visible,
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(1),
          child: pw.Text(
            titleDer,
            style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
            maxLines: 2,
            overflow: pw.TextOverflow.visible,
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(1),
          child: pw.Text(
            valueDer,
            style: pw.TextStyle(fontSize: 10),
            maxLines: 2,
            overflow: pw.TextOverflow.visible,
          ),
        ),
      ],
    );
  }

  static pw.TableRow _buildTripleTableRow(
      String titleIzq,
      String valueIzq,
      String titleCenter,
      String valueCenter,
      String titleDer,
      String valueDer) {
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(1),
          child: pw.Text(
            titleIzq,
            style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
            maxLines: 2, // Limita el texto a 2 líneas
            overflow: pw.TextOverflow.visible, // Permite que el texto se ajuste
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(1),
          child: pw.Text(
            valueIzq,
            style: pw.TextStyle(fontSize: 10),
            maxLines: 2,
            overflow: pw.TextOverflow.visible,
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(1),
          child: pw.Text(
            titleCenter,
            style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
            maxLines: 2,
            overflow: pw.TextOverflow.visible,
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(1),
          child: pw.Text(
            valueCenter,
            style: pw.TextStyle(fontSize: 10),
            maxLines: 2,
            overflow: pw.TextOverflow.visible,
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(1),
          child: pw.Text(
            titleDer,
            style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
            maxLines: 2,
            overflow: pw.TextOverflow.visible,
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(1),
          child: pw.Text(
            valueDer,
            style: pw.TextStyle(fontSize: 10),
            maxLines: 2,
            overflow: pw.TextOverflow.visible,
          ),
        ),
      ],
    );
  }
}
