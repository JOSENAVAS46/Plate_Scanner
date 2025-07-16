import 'package:intl/intl.dart';

class DateTimeHandler {
  // METODO PARA OBTENER LA PRIMERA FECHA DEL MES Y LA ULTIMA FECHA DEL MES
  List<DateTime> getFirstLastTodayDateOfMonth(DateTime date) {
    DateTime firstDate = DateTime(date.year, date.month, 1);
    DateTime lastDate = DateTime(date.year, date.month + 1, 0);
    DateTime today = DateTime.now();
    return [firstDate, lastDate, today];
  }

  String? formatDateApi(String? dateStr) {
    if (dateStr == null) return null;
    try {
      DateTime parsedDate =
          DateFormat('EEE, d MMM yyyy HH:mm:ss zzz').parse(dateStr);
      String? formattedDateTime = DateFormat('dd/MM/yy ').format(parsedDate);
      return formattedDateTime;
    } catch (e) {
      return null;
    }
  }

  String getFormattedDate_SmallDateTime(String fechaString) {
    DateTime fecha = DateTime.parse(fechaString);
    return DateFormat('yyyy-MM-dd').format(fecha);
  }

  String? formatDateSpanishApi(String? dateStr) {
    if (dateStr == null) return null;
    try {
      DateTime parsedDate =
          DateFormat('EEE, dd MMM yyyy HH:mm:ss').parseUtc(dateStr);
      // Map the days and months to Spanish
      Map<String, String> daysInSpanish = {
        'Monday': 'LUNES',
        'Tuesday': 'MARTES',
        'Wednesday': 'MIERCOLES',
        'Thursday': 'JUEVES',
        'Friday': 'VIERNES',
        'Saturday': 'SABADO',
        'Sunday': 'DOMINGO',
      };

      Map<String, String> monthsInSpanish = {
        'January': 'ENE. ',
        'February': 'FEB.',
        'March': 'MAR.',
        'April': 'ABR.',
        'May': 'MAY.',
        'June': 'JUN.',
        'July': 'JUL.',
        'August': 'AGO.',
        'September': 'SEPT.',
        'October': 'OCT.',
        'November': 'NOV.',
        'December': 'DIC.',
      };
      String day = daysInSpanish[DateFormat('EEEE').format(parsedDate)]!;
      String dayNumber = DateFormat('dd').format(parsedDate);
      String month = monthsInSpanish[DateFormat('MMMM').format(parsedDate)]!;
      String year = DateFormat('yyyy').format(parsedDate);
      String dateString = '$dayNumber DE $month DEL $year';
      return dateString;
    } catch (e) {
      return null;
    }
  }

  String? formatDateTimeSpanishApi(String? dateStr) {
    if (dateStr == null) return null;
    try {
      DateTime parsedDate =
          DateFormat('EEE, dd MMM yyyy HH:mm:ss').parseUtc(dateStr);

      // Mapeo de días y meses en español
      Map<String, String> daysInSpanish = {
        'Monday': 'LUNES',
        'Tuesday': 'MARTES',
        'Wednesday': 'MIÉRCOLES',
        'Thursday': 'JUEVES',
        'Friday': 'VIERNES',
        'Saturday': 'SÁBADO',
        'Sunday': 'DOMINGO',
      };

      Map<String, String> monthsInSpanish = {
        'January': 'ENE.',
        'February': 'FEB.',
        'March': 'MAR.',
        'April': 'ABR.',
        'May': 'MAY.',
        'June': 'JUN.',
        'July': 'JUL.',
        'August': 'AGO.',
        'September': 'SEPT.',
        'October': 'OCT.',
        'November': 'NOV.',
        'December': 'DIC.',
      };

      // Obtener el día, mes, año y hora
      String day = daysInSpanish[DateFormat('EEEE').format(parsedDate)]!;
      String dayNumber = DateFormat('dd').format(parsedDate);
      String month = monthsInSpanish[DateFormat('MMMM').format(parsedDate)]!;
      String year = DateFormat('yyyy').format(parsedDate);
      String time = DateFormat('HH:mm:ss').format(parsedDate);

      // Construir la cadena final
      String dateTimeString = '$dayNumber DE $month DEL $year\n$time';
      return dateTimeString;
    } catch (e) {
      return null;
    }
  }

  String? formatTimeApi(String? dateStr) {
    if (dateStr == null) return null;
    try {
      DateTime parsedDate =
          DateFormat('EEE, d MMM yyyy HH:mm:ss zzz').parse(dateStr);
      String? formattedDateTime = DateFormat('HH:mm').format(parsedDate);
      return formattedDateTime;
    } catch (e) {
      return null;
    }
  }

  static String getFormattedTime_TimeSpanPathPDF(DateTime time) {
    String hour = time.hour.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');
    String second = time.second.toString().padLeft(2, '0');

    return '$hour-$minute-$second';
  }

  static String formatTodayDateTimePathPDF(DateTime dateTime) {
    String year = dateTime.year.toString();
    String month = dateTime.month.toString().padLeft(2, '0');
    String day = dateTime.day.toString().padLeft(2, '0');

    return '$year-$month-${day}H${getFormattedTime_TimeSpanPathPDF(dateTime)}';
  }

  String? formatFechaFooterPhoto(String fecha) {
    if (fecha == '') return null;
    if (fecha.isEmpty) return null;
    DateTime dateTime = DateTime.parse(fecha);

    // Crear un mapa de los meses en español
    const Map<int, String> meses = {
      1: 'enero',
      2: 'febrero',
      3: 'marzo',
      4: 'abril',
      5: 'mayo',
      6: 'junio',
      7: 'julio',
      8: 'agosto',
      9: 'septiembre',
      10: 'octubre',
      11: 'noviembre',
      12: 'diciembre',
    };

    // Obtener los componentes de la fecha
    int dia = dateTime.day;
    int mes = dateTime.month;
    int anio = dateTime.year;
    int hora = dateTime.hour;
    int minuto = dateTime.minute;
    int segundo = dateTime.second;

    String fechaString = '$dia de ${meses[mes]} del $anio';
    String horaString =
        '${hora.toString().padLeft(2, '0')}:${minuto.toString().padLeft(2, '0')}:${segundo.toString().padLeft(2, '0')}';
    // Formatear la fecha
    String fechaFormateada = '$fechaString a las $horaString';
    return fechaFormateada;
  }
}
