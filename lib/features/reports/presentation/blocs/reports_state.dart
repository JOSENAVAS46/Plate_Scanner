part of 'reports_bloc.dart';

class ReportsState {
  final FormStatus formStatus;

  const ReportsState({
    this.formStatus = const InitialState(),
  });

  ReportsState copyWith({
    FormStatus? formStatus,
  }) {
    return ReportsState(
      formStatus: formStatus ?? this.formStatus,
    );
  }
}

final class InitialState extends FormStatus {
  const InitialState();
}

final class LoadingState extends FormStatus {
  final String mensaje;
  const LoadingState({required this.mensaje});
}

final class MessageState extends FormStatus {
  final String mensaje;
  final TipoMensajeBloc tipo;
  const MessageState({required this.mensaje, required this.tipo});
}

final class ListaVehiculosCSVLoadedState extends FormStatus {
  final List<VehiculoCsvModel> vehiculos;

  const ListaVehiculosCSVLoadedState({required this.vehiculos});
}

final class RecibirConsultaState extends FormStatus {
  final ResConsultaModel response;
  const RecibirConsultaState({required this.response});
}

final class RecibirDataReportState extends FormStatus {
  final ResReportDataModel response;
  const RecibirDataReportState({required this.response});
}

class PdfReadyState extends FormStatus {
  final String pdfPath;
  PdfReadyState({required this.pdfPath});
}
