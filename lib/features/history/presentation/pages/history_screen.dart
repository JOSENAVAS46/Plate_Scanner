import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plate_scanner_app/core/styles/style_adm.dart';
import 'package:plate_scanner_app/core/utils/dialogs.dart';
import 'package:plate_scanner_app/features/history/domain/entities/vehiculo_response.dart';
import 'package:plate_scanner_app/features/history/presentation/blocs/history_bloc.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabTypes = [
    'M',
    'D'
  ]; // Tipos correspondientes a cada tab

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Cargar datos iniciales
    context.read<HistoryBloc>().add(GetHistoryByTipoEvent(tipo: 'M'));

    // Añade listener para detectar cambios al deslizar
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (!_tabController.indexIsChanging) {
      final tipo = _tabTypes[_tabController.index];
      context.read<HistoryBloc>().add(GetHistoryByTipoEvent(tipo: tipo));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Historial',
          style: StyleApp.bigTitleStyleBlanco,
        ),
        centerTitle: true,
        backgroundColor: StyleApp.appColorPrimary,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Manual'),
            Tab(text: 'Detecciones'),
          ],
          onTap: (index) {
            final tipo = _tabTypes[index];
            context.read<HistoryBloc>().add(GetHistoryByTipoEvent(tipo: tipo));
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () => _showDeleteTabDialog(context),
            tooltip: 'Eliminar registros de esta categoría',
          ),
        ],
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildHistoryList('M'),
            _buildHistoryList('D'),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryList(String tipo) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      buildWhen: (previous, current) {
        // Verifica si el estado actual es para el tipo correcto
        if (current.formStatus is GetHistoryRecibidaState) {
          return (current.formStatus as GetHistoryRecibidaState).tipo == tipo;
        }
        return true;
      },
      builder: (context, state) {
        if (state.formStatus is LoadingState && state.currentTipo == tipo) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.formStatus is MessageState && state.currentTipo == tipo) {
          final message = (state.formStatus as MessageState).mensaje;
          return Center(
              child: Text(
            message,
            style: StyleApp.regularTxtStyleBlanco,
            textAlign: TextAlign.center,
          ));
        }

        if (state.formStatus is GetHistoryRecibidaState) {
          final historyState = state.formStatus as GetHistoryRecibidaState;
          if (historyState.tipo != tipo) return const SizedBox.shrink();

          final historyList = historyState.response;
          final filteredList =
              historyList.where((item) => item.tipo == tipo).toList();

          if (filteredList.isEmpty) {
            return Center(
              child: Text(
                'No hay registros disponibles',
                style: StyleApp.regularTxtStyle,
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              final item = filteredList[index];
              final vehiculoResponse =
                  VehiculoResponse.fromJson(jsonDecode(item.objeto!));
              final vehiculo = vehiculoResponse.vehiculo;

              return Card(
                color: StyleApp.appColorBlanco,
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    if (item.base64Img != null) {
                      _showImageDialog(
                          context, item.base64Img!, vehiculo.placa);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              vehiculo.placa,
                              style: StyleApp.regularTxtStyleBold.copyWith(
                                fontSize: 20,
                                color: StyleApp.appColorPrimary,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () =>
                                  _showDeleteItemDialog(context, item.id!),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        _buildInfoRow('Marca', vehiculo.marca),
                        _buildInfoRow('Modelo', vehiculo.modelo),
                        _buildInfoRow('Año', vehiculo.anio),
                        _buildInfoRow('Color', vehiculo.color),
                        _buildInfoRow('Clase', vehiculo.clase),
                        _buildInfoRow('Servicio', vehiculo.servicio),
                        if (item.base64Img != null) ...[
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.photo,
                                  size: 16, color: Colors.grey[600]),
                              const SizedBox(width: 4),
                              Text(
                                'Contiene imagen - Toca para ver',
                                style: StyleApp.regularTxtStyle.copyWith(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }

        return Center(
          child: Text(
            'Seleccione una opción',
            style: StyleApp.regularTxtStyleBlanco,
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: StyleApp.regularTxtStyleBold,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: StyleApp.regularTxtStyle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteTabDialog(BuildContext context) {
    final currentTab = _tabController.index;
    final tipo = _tabTypes[currentTab];
    final tabName = currentTab == 0 ? 'Manual' : 'Detecciones';

    DialogsAdm.mostrarPregunta(
        context: context,
        mensaje:
            '¿Está seguro que desea eliminar todos los registros de $tabName?',
        onConfirm: () {
          context.read<HistoryBloc>().add(DeleteHistoryByTipoEvent(tipo: tipo));
        },
        onCancel: () {});
  }

  void _showDeleteItemDialog(BuildContext context, int id) {
    DialogsAdm.mostrarPregunta(
        context: context,
        mensaje: '¿Está seguro que desea eliminar este registro?',
        onConfirm: () {
          context.read<HistoryBloc>().add(DeleteHistoryByIdEvent(id: id));
        },
        onCancel: () {});
  }

  void _showImageDialog(
      BuildContext context, String base64Image, String placa) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
            color: StyleApp.appColorBlanco,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                placa,
                style: StyleApp.regularTxtStyleBold.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.memory(
                  base64Decode(base64Image),
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: StyleApp.appColorPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cerrar',
                    style: StyleApp.regularTxtStyleBold.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
