part of 'identification_bloc.dart';

class IdentificationState {
  final FormStatus formStatus;

  const IdentificationState({
    this.formStatus = const InitialState(),
  });

  IdentificationState copyWith({
    FormStatus? formStatus,
  }) {
    return IdentificationState(
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

final class DeteccionRecibidaState extends FormStatus {
  final ResDetectInputModel response;
  const DeteccionRecibidaState({required this.response});
}
