part of 'input_plate_bloc.dart';

class InputPlateState {
  final FormStatus formStatus;
  const InputPlateState({
    this.formStatus = const InitialState(),
  });

  InputPlateState copyWith({
    FormStatus? formStatus,
  }) {
    return InputPlateState(
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

final class VehiculoRecibidoState extends FormStatus {
  final ResDetectInputModel response;
  const VehiculoRecibidoState({required this.response});
}
