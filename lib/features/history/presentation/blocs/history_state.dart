part of 'history_bloc.dart';

class HistoryState {
  final FormStatus formStatus;
  final String? currentTipo;

  const HistoryState({
    this.formStatus = const InitialState(),
    this.currentTipo,
  });

  HistoryState copyWith({
    FormStatus? formStatus,
    String? currentTipo,
  }) {
    return HistoryState(
      formStatus: formStatus ?? this.formStatus,
      currentTipo: currentTipo ?? this.currentTipo,
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

final class GetHistoryRecibidaState extends FormStatus {
  final List<AuxHistoryConverterModel> response;
  final String tipo;

  GetHistoryRecibidaState({
    required this.response,
    required this.tipo,
  });
}
