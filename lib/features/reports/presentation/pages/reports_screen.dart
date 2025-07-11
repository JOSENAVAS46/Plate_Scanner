import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:plate_scanner_app/core/enums/enum.dart';
import 'package:plate_scanner_app/core/styles/style_adm.dart';
import 'package:plate_scanner_app/core/utils/date_time_handler.dart';
import 'package:plate_scanner_app/core/utils/dialogs.dart';
import 'package:plate_scanner_app/features/_other/presentation/pages/loading_screen.dart';
import 'package:plate_scanner_app/features/_other/presentation/widgets/custom_dropdown_button.dart';
import 'package:plate_scanner_app/features/_other/presentation/widgets/custom_elevated_button.dart';
import 'package:plate_scanner_app/features/_other/presentation/widgets/separador.dart';
import 'package:plate_scanner_app/features/_other/presentation/widgets/text_field_custom.dart';
import 'package:plate_scanner_app/features/reports/data/models/res_report_data_model.dart';
import 'package:plate_scanner_app/features/reports/presentation/blocs/reports_bloc.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  DateTime? _startDate =
      DateTimeHandler().getFirstAndLastDateOfMonth(DateTime.now())[0];
  DateTime? _endDate =
      DateTimeHandler().getFirstAndLastDateOfMonth(DateTime.now())[2];
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTopButton = false;
  List<DropdownMenuItem<String>> _dropdownItems = [
    DropdownMenuItem(value: 'T', child: Text('Todos')),
    DropdownMenuItem(value: 'D', child: Text('Detectado')),
    DropdownMenuItem(value: 'M', child: Text('Manual')),
  ];
  String _selectedType = 'T';
  List<Datum> _consultas = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    setState(() {
      _showBackToTopButton = _scrollController.offset >= 200;
    });
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    _consultas.clear();
    final DateTime? picked = await showDatePicker(
      locale: const Locale('es', 'ES'),
      context: context,
      initialDate: isStartDate
          ? _startDate ??
              DateTimeHandler().getFirstAndLastDateOfMonth(DateTime.now())[2]
          : _endDate ??
              DateTimeHandler().getFirstAndLastDateOfMonth(DateTime.now())[2],
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<ReportsBloc, ReportsState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is RecibirDataReportState) {
          if (formStatus.response.data != null &&
              formStatus.response.data!.isNotEmpty) {
            _consultas = formStatus.response.data!.cast<Datum>();
          } else {
            DialogsAdm.msjError(
                context: context,
                mensaje:
                    formStatus.response.message ?? 'No se encontraron datos');
          }
        } else if (formStatus is PdfReadyState) {
          final pdfState = state.formStatus as PdfReadyState;
          _openPdf(context, pdfState.pdfPath);
        } else if (formStatus is MessageState) {
          if (formStatus.tipo == TipoMensajeBloc.error) {
            DialogsAdm.msjError(context: context, mensaje: formStatus.mensaje);
          } else if (formStatus.tipo == TipoMensajeBloc.success) {
            DialogsAdm.msjExito(context: context, mensaje: formStatus.mensaje);
          } else {
            DialogsAdm.msjSistema(
                context: context, mensaje: formStatus.mensaje);
          }
        }
      },
      child: BlocBuilder<ReportsBloc, ReportsState>(
        builder: (context, state) {
          if (state.formStatus is LoadingState) {
            return LoadingScreen(
                mensaje: (state.formStatus as LoadingState).mensaje);
          }
          return Scaffold(
            appBar: AppBar(
              title: Text('Reportes', style: StyleApp.bigTitleStyleBlanco),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              centerTitle: true,
              backgroundColor: StyleApp.appColorPrimary,
              actions: [
                if (_consultas.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.picture_as_pdf_rounded),
                    onPressed: () {
                      setState(() {
                        if (_startDate != null ||
                            _endDate != null ||
                            _selectedType.isNotEmpty) {
                          context.read<ReportsBloc>().add(GetPdfReportEvent(
                              fechaDesde: _startDate!,
                              fechaHasta: _endDate!,
                              tipo: _selectedType));
                        } else {
                          DialogsAdm.msjError(
                              context: context,
                              mensaje: 'Debe seleccionar todos los filtros');
                        }
                      });
                    },
                  ),
              ],
            ),
            body: SafeArea(
              child: Column(
                children: [
                  // Date filter controls
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () => _selectDate(context, true),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _startDate == null
                                            ? 'Fecha inicial'
                                            : DateFormat('dd/MM/yyyy')
                                                .format(_startDate!),
                                        style: StyleApp.regularTxtStyleBlanco,
                                      ),
                                      const Icon(Icons.calendar_today_rounded),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: InkWell(
                                onTap: () => _selectDate(context, false),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _endDate == null
                                            ? 'Fecha final'
                                            : DateFormat('dd/MM/yyyy')
                                                .format(_endDate!),
                                        style: StyleApp.regularTxtStyleBlanco,
                                      ),
                                      const Icon(Icons.calendar_month_rounded),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SeparadorAltura(size: size, porcentaje: 2),
                        CustomDropdownButton(
                          value: _selectedType,
                          items: _dropdownItems,
                          onChanged: (value) {
                            setState(() {
                              _consultas.clear();

                              _selectedType = value!;
                            });
                          },
                          isPrimary: false, // o false para el estilo secundario
                        ),
                        SeparadorAltura(size: size, porcentaje: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: CustomElevatedButton(
                                text: 'Limpiar',
                                isPrimary: false,
                                onPressed: () {
                                  setState(() {
                                    _consultas.clear();
                                    _selectedType = 'T';
                                    _startDate = DateTimeHandler()
                                        .getFirstAndLastDateOfMonth(
                                            DateTime.now())[0];
                                    _endDate = DateTimeHandler()
                                        .getFirstAndLastDateOfMonth(
                                            DateTime.now())[2];
                                  });
                                },
                              ),
                            ),
                            SeparadorAncho(size: size, porcentaje: 2),
                            Expanded(
                              flex: 1,
                              child: CustomElevatedButton(
                                text: 'Buscar',
                                onPressed: () {
                                  if (_startDate != null ||
                                      _endDate != null ||
                                      _selectedType.isNotEmpty) {
                                    _consultas.clear();
                                    context.read<ReportsBloc>().add(
                                        GetDataReportEvent(
                                            fechaDesde: _startDate!,
                                            fechaHasta: _endDate!,
                                            tipo: _selectedType));
                                  } else {
                                    DialogsAdm.msjError(
                                        context: context,
                                        mensaje:
                                            'Debe seleccionar todos los filtros');
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: StyleApp.appColorPrimary,
                    thickness: 2,
                  ),
                  SeparadorAltura(size: size, porcentaje: 1),
                  Expanded(
                    child: _consultas.isEmpty
                        ? Center(
                            child: Text(
                              'No hay consultas para mostrar',
                              style: StyleApp.regularTxtStyleBlanco,
                            ),
                          )
                        : ListView.builder(
                            controller: _scrollController,
                            itemCount: _consultas.length,
                            itemBuilder: (context, index) {
                              return _ConsultaCard(consulta: _consultas[index]);
                            },
                          ),
                  ),
                ],
              ),
            ),
            floatingActionButton: _showBackToTopButton
                ? FloatingActionButton(
                    onPressed: _scrollToTop,
                    backgroundColor: StyleApp.appColorPrimary,
                    child: const Icon(Icons.arrow_upward, color: Colors.white),
                  )
                : null,
          );
        },
      ),
    );
  }
}

Future<void> _openPdf(BuildContext context, String pdfPath) async {
  final result = await OpenFile.open(pdfPath);

  if (result.type != ResultType.done && context.mounted) {
    DialogsAdm.msjError(
      context: context,
      mensaje: 'No se pudo abrir el PDF: ${result.message}',
    );
  }
}

class _ConsultaCard extends StatelessWidget {
  final Datum consulta;

  const _ConsultaCard({required this.consulta});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: StyleApp.appColorBlanco,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  consulta.placa ?? 'Sin placa',
                  style: StyleApp.mediumTitleStyleBold,
                ),
                Chip(
                  label: Text(
                    consulta.tipo == 'M' ? 'Manual' : 'Detectado',
                    style: StyleApp.smallTxtStyleBlancoBold,
                  ),
                  backgroundColor: consulta.tipo == 'M'
                      ? StyleApp.appColorPlomo
                      : StyleApp.appColorPrimary,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              DateFormat('dd/MM/yyyy HH:mm')
                  .format(consulta.fechaHoraConsulta ?? DateTime.now()),
              style: StyleApp.smallTxtStyleBold,
            ),
            const SizedBox(height: 12),
            if (consulta.placa != null) ...[
              _buildInfoRow('Marca', consulta.marcaVehiculo ?? 'N/A'),
              _buildInfoRow('Modelo', consulta.modeloVehiculo ?? 'N/A'),
              _buildInfoRow('Color', consulta.colorVehiculo ?? 'N/A'),
              _buildInfoRow('Año', consulta.anioVehiculo?.toString() ?? 'N/A'),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text('$label:', style: StyleApp.regularTxtStyleBold),
          ),
          Expanded(child: Text(value, style: StyleApp.regularTxtStyle)),
        ],
      ),
    );
  }
}
