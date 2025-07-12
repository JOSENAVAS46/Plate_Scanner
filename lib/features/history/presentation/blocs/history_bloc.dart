import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:plate_scanner_app/core/cache/database/crud_database/crud_history.dart';
import 'package:plate_scanner_app/core/enums/enum.dart';
import 'package:plate_scanner_app/features/_other/data/models/aux_history_converter_model.dart';
import 'package:plate_scanner_app/features/_other/data/models/form_status.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final CrudHistory crudHistory = CrudHistory();

  HistoryBloc() : super(HistoryState()) {
    on<GetHistoryByTipoEvent>(_onGetHistoryByTipoEvent);
    on<DeleteAllHistoryEvent>(_onDeleteAllHistoryEvent);
    on<DeleteHistoryByTipoEvent>(_onDeleteHistoryByTipoEvent);
    on<DeleteHistoryByIdEvent>(_onDeleteHistoryByIdEvent);
  }

  Future<void> _onDeleteHistoryByIdEvent(
      DeleteHistoryByIdEvent event, Emitter<HistoryState> emit) async {
    emit(state.copyWith(
        formStatus: LoadingState(mensaje: 'Eliminando registro...')));
    try {
      final deletedCount = await crudHistory.delete(event.id);

      if (deletedCount > 0) {
        emit(state.copyWith(
          formStatus: MessageState(
            mensaje: 'Registro eliminado correctamente',
            tipo: TipoMensajeBloc.success,
          ),
        ));
        // Refrescar la lista
        add(GetHistoryByTipoEvent(tipo: 'M'));
        add(GetHistoryByTipoEvent(tipo: 'D'));
      } else {
        emit(state.copyWith(
          formStatus: MessageState(
            mensaje: 'No se encontró el registro para eliminar',
            tipo: TipoMensajeBloc.info,
          ),
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        formStatus: MessageState(
          mensaje: 'Error al eliminar el registro: ${e.toString()}',
          tipo: TipoMensajeBloc.error,
        ),
      ));
    }
  }

  Future<void> _onDeleteHistoryByTipoEvent(
      DeleteHistoryByTipoEvent event, Emitter<HistoryState> emit) async {
    emit(state.copyWith(
        formStatus: LoadingState(mensaje: 'Eliminando registros...')));

    try {
      final deletedCount = await crudHistory.deleteHistoryByTipo(event.tipo);

      if (deletedCount > 0) {
        emit(state.copyWith(
          formStatus: MessageState(
            mensaje: 'Se eliminaron $deletedCount registros',
            tipo: TipoMensajeBloc.success,
          ),
        ));
        // Refrescar la lista
        add(GetHistoryByTipoEvent(tipo: event.tipo));
      } else {
        emit(state.copyWith(
          formStatus: MessageState(
            mensaje: 'No se encontraron registros para eliminar',
            tipo: TipoMensajeBloc.info,
          ),
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        formStatus: MessageState(
          mensaje: 'Error al eliminar registros: ${e.toString()}',
          tipo: TipoMensajeBloc.error,
        ),
      ));
    }
  }

  Future<void> _onDeleteAllHistoryEvent(
      DeleteAllHistoryEvent event, Emitter<HistoryState> emit) async {
    emit(state.copyWith(
        formStatus: LoadingState(mensaje: 'Eliminando historial...')));
    try {
      await crudHistory.deleteAll();
      emit(state.copyWith(
        formStatus: MessageState(
          mensaje: 'Historial eliminado correctamente',
          tipo: TipoMensajeBloc.success,
        ),
      ));
      add(GetHistoryByTipoEvent(tipo: 'M'));
      add(GetHistoryByTipoEvent(tipo: 'D'));
    } catch (e) {
      emit(state.copyWith(
        formStatus: MessageState(
          mensaje: 'Error al eliminar el historial: ${e.toString()}',
          tipo: TipoMensajeBloc.error,
        ),
      ));
    }
  }

  Future<void> _onGetHistoryByTipoEvent(
      GetHistoryByTipoEvent event, Emitter<HistoryState> emit) async {
    emit(state.copyWith(
      formStatus: LoadingState(mensaje: 'Cargando historial...'),
      currentTipo: event.tipo, // Añade esto
    ));

    try {
      final response = await crudHistory.getHistoryByTipo(event.tipo);
      if (response.isEmpty) {
        emit(state.copyWith(
          formStatus: MessageState(
            mensaje: 'No se encontraron registros para el tipo seleccionado',
            tipo: TipoMensajeBloc.info,
          ),
          currentTipo: event.tipo, // Añade esto
        ));
      } else {
        emit(state.copyWith(
          formStatus: GetHistoryRecibidaState(
            response: response,
            tipo: event.tipo,
          ),
          currentTipo: event.tipo, // Añade esto
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        formStatus: MessageState(
          mensaje: 'Error al obtener el historial: ${e.toString()}',
          tipo: TipoMensajeBloc.error,
        ),
        currentTipo: event.tipo, // Añade esto
      ));
    }
  }
}
