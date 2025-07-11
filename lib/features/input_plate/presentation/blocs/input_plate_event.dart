part of 'input_plate_bloc.dart';

@immutable
sealed class InputPlateEvent {}

class SendInputPlateEvent extends InputPlateEvent {
  final String plate;

  SendInputPlateEvent({required this.plate});
}
