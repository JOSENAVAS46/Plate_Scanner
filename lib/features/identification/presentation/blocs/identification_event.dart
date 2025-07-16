part of 'identification_bloc.dart';

@immutable
sealed class IdentificationEvent {}

class SendImgBytesEvent extends IdentificationEvent {
  final String imagePath;

  SendImgBytesEvent({required this.imagePath});
}

class GetCombinationImagePlateEvent extends IdentificationEvent {
  final String plate;

  GetCombinationImagePlateEvent({
    required this.plate,
  });
}
