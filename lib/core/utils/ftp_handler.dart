import 'dart:io';

import 'package:plate_scanner_app/core/cache/cache_app.dart';
import 'package:ftpconnect/ftpconnect.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class FtpHandler {
  String apiUrl = CacheApp().getApiUrl();
  late FTPConnect ftpConnect;

  Future<void> iniciarFtpConnect() async {
    /*
    final credencialesFtp = await CrudParametros().getFirstParametro();
    ftpConnect = FTPConnect(credencialesFtp.servidorFtp ?? '',
        port: credencialesFtp.puerto,
        user: credencialesFtp.usuarioFtp ?? '',
        pass: credencialesFtp.claveFtp ?? '',
        showLog: false,
        timeout: 30);

     */
  }

  Future<String> guardarPdfFTP(File file, String directorioPdf) async {
    try {
      await iniciarFtpConnect();
      print('INICIO DE GUARDAR PDF EN FTP CLOUD ...');
      print('EXISTE? : ${await file.exists()}');
      print("PESO DEL PDF: ${file.lengthSync()}");
      print("PATH DEL PDF: ${file.path}");
      print('CONECTANDO A FTP ...');
      await ftpConnect.connect();
      ftpConnect.supportIPV6 = true;
      if (await ftpConnect.checkFolderExistence(directorioPdf)) {
        print('Existe el directorio de PDF ...');
        await ftpConnect.changeDirectory(directorioPdf);
      } else {
        print('Se creo el Directorio de PDF ...');
        await ftpConnect.makeDirectory(directorioPdf);
        await ftpConnect.changeDirectory(directorioPdf);
      }
      if (await ftpConnect.existFile(basename(file.path))) {
        print('PDF EXISTENTE ...');
        return 'EXIST';
      } else {
        print('SUBIENDO PDF ...');
        await ftpConnect.sendCustomCommand('TYPE I');
        await ftpConnect.uploadFileWithRetry(file, pRetryCount: 3);
        return 'OK';
      }
    } catch (e) {
      print('Error uploading file: ${e.toString()}');
      return 'ERROR';
    } finally {
      await ftpConnect.sendCustomCommand('TYPE A');
      await ftpConnect.disconnect();
    }
  }

  Future<void> downloadFileFromFtp(
      {required String directorioLocal,
      required String directorioFTP,
      required String nombreArchivoFTP}) async {
    try {
      await iniciarFtpConnect();
      final filePath = '$directorioLocal/$nombreArchivoFTP';
      final file = File(filePath);
      print('INICIO DE DESCARGAR IMAGEN DE FTP CLOUD ...');
      await ftpConnect.connect();
      try {
        await ftpConnect.sendCustomCommand('TYPE I');
        await ftpConnect.downloadFile(
          join(directorioFTP, nombreArchivoFTP),
          file,
          onProgress: (progressInPercent, totalReceived, fileSize) {
            final progressBar = _createProgressBar(progressInPercent);
            stdout.write(
                '\r$progressBar $progressInPercent% - $totalReceived/$fileSize');
          },
        );
        print('Archivo descargado correctamente: $nombreArchivoFTP');
      } catch (e) {
        print('Error al descargar: ${e.toString()}');
        return;
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return;
    } finally {
      await ftpConnect.sendCustomCommand('TYPE A');
      await ftpConnect.disconnect();
    }
  }

  String _createProgressBar(double progressInPercent) {
    final int barWidth = 50;
    final int filledBars = (barWidth * progressInPercent / 100).round();
    final int emptyBars = barWidth - filledBars;
    return '[${'=' * filledBars}${' ' * emptyBars}]';
  }

  String extractPathFromFTPUrl(String url) {
    final uri = Uri.parse(url);
    return uri.path;
  }

  Future<void> descargarAvatarImgage(String url) async {
    if (url.isEmpty) {
      print('URL está vacía');
      return;
    }

    final path = extractPathFromFTPUrl(url);
    print('Path extraído: $path');
    final pathSplit = path.split('/');
    pathSplit.removeLast();
    final pathFinal = pathSplit.join('/');
    print('Directorio final: $pathFinal');

    final directories = await getExternalStorageDirectories();
    if (directories == null || directories.isEmpty) {
      print('No se encontró el directorio de almacenamiento externo');
      return;
    }
    final directorio = '${directories.first.path}/fotos';
    print('Directorio local: $directorio');

    await downloadFileFromFtp(
      directorioLocal: directorio,
      directorioFTP: pathFinal,
      nombreArchivoFTP: basename(path),
    );
  }
}
