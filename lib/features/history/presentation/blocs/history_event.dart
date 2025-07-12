part of 'history_bloc.dart';

@immutable
sealed class HistoryEvent {}

class GetHistoryByTipoEvent extends HistoryEvent {
  final String tipo;
  GetHistoryByTipoEvent({required this.tipo});
}

class DeleteAllHistoryEvent extends HistoryEvent {}

class DeleteHistoryByTipoEvent extends HistoryEvent {
  final String tipo;
  DeleteHistoryByTipoEvent({required this.tipo});
}

class DeleteHistoryByIdEvent extends HistoryEvent {
  final int id;
  DeleteHistoryByIdEvent({required this.id});
}
