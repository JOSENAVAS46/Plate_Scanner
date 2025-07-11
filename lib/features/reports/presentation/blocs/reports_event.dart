part of 'reports_bloc.dart';

@immutable
sealed class ReportsEvent {}

class GetVehiculosCSVEvent extends ReportsEvent {
  GetVehiculosCSVEvent();
}

class GetConsultasByUserEvent extends ReportsEvent {
  GetConsultasByUserEvent();
}

class GetPdfReportEvent extends ReportsEvent {
  final DateTime fechaDesde;
  final DateTime fechaHasta;
  final String tipo;

  GetPdfReportEvent({
    required this.fechaDesde,
    required this.fechaHasta,
    required this.tipo,
  });
}

class GetDataReportEvent extends ReportsEvent {
  final DateTime fechaDesde;
  final DateTime fechaHasta;
  final String tipo;

  GetDataReportEvent({
    required this.fechaDesde,
    required this.fechaHasta,
    required this.tipo,
  });
}
