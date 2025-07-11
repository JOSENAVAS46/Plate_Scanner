import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:plate_scanner_app/core/styles/style_adm.dart';
import 'package:plate_scanner_app/features/_other/presentation/widgets/separador.dart';

class DateTimePickerWidget extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final VoidCallback? onDateTimeSelected;
  final bool showTimePicker;
  final Size size;

  const DateTimePickerWidget({
    super.key,
    required this.controller,
    required this.size,
    this.label = 'Fecha y Hora',
    this.onDateTimeSelected,
    this.showTimePicker = true,
  });

  @override
  State<DateTimePickerWidget> createState() => _DateTimePickerWidgetState();
}

class _DateTimePickerWidgetState extends State<DateTimePickerWidget> {
  late DateTime _selectedDateTime;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;

    // Intenta parsear la fecha del controlador si tiene valor
    if (_controller.text.isNotEmpty) {
      try {
        _selectedDateTime = DateTime.parse(_controller.text);
      } catch (_) {
        _selectedDateTime = DateTime.now();
      }
    } else {
      _selectedDateTime = DateTime.now();
    }

    _updateControllerText();

    // Agrega listener para cambios externos en el controlador
    _controller.addListener(_handleControllerChange);
  }

  @override
  void didUpdateWidget(DateTimePickerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_handleControllerChange);
      _controller = widget.controller;
      _controller.addListener(_handleControllerChange);
      _syncDateTimeFromController();
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleControllerChange);
    super.dispose();
  }

  void _handleControllerChange() {
    if (!mounted) return;
    _syncDateTimeFromController();
  }

  void _syncDateTimeFromController() {
    if (_controller.text.isNotEmpty) {
      try {
        final newDateTime = DateTime.parse(_controller.text);
        if (newDateTime != _selectedDateTime) {
          setState(() {
            _selectedDateTime = newDateTime;
          });
        }
      } catch (_) {
        // No hacer nada si el parseo falla
      }
    }
  }

  void _updateControllerText() {
    _controller.text = _formatDateTime(_selectedDateTime);
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = widget.showTimePicker
          ? await showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
            )
          : TimeOfDay.fromDateTime(_selectedDateTime);

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          _updateControllerText();
          widget.onDateTimeSelected?.call();
        });
      }
    }
  }

  void _handleManualInput(String value) {
    try {
      final parsedDateTime = DateTime.parse(value);
      if (parsedDateTime.isAfter(DateTime(2000))) {
        setState(() {
          _selectedDateTime = parsedDateTime;
        });
      }
    } catch (_) {
      // Mantener el valor anterior si el parseo falla
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SeparadorAltura(size: widget.size, porcentaje: 1),
        Row(
          children: <Widget>[
            SeparadorAncho(size: widget.size, porcentaje: 2),
            Expanded(
              child: Column(
                children: [
                  SeparadorAltura(size: widget.size, porcentaje: 1),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese una fecha y hora válida';
                      }
                      try {
                        DateTime.parse(value);
                        return null;
                      } catch (_) {
                        return 'Formato inválido (YYYY-MM-DD HH:MM)';
                      }
                    },
                    controller: _controller,
                    decoration: InputDecoration(
                      labelStyle: StyleApp.regularTxtStyleBold
                          .copyWith(color: StyleApp.appColorPrimary),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: widget.label,
                      hintText: 'YYYY-MM-DD HH:MM',
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.calendar_today_rounded,
                              color: StyleApp.appColorPrimary,
                              size: 25,
                            ),
                            onPressed: () => _selectDate(context),
                          ),
                          if (widget.showTimePicker)
                            IconButton(
                              icon: Icon(
                                Icons.access_time_rounded,
                                color: StyleApp.appColorPrimary,
                                size: 25,
                              ),
                              onPressed: () async {
                                final TimeOfDay? pickedTime =
                                    await showTimePicker(
                                  context: context,
                                  initialTime:
                                      TimeOfDay.fromDateTime(_selectedDateTime),
                                );
                                if (pickedTime != null) {
                                  setState(() {
                                    _selectedDateTime = DateTime(
                                      _selectedDateTime.year,
                                      _selectedDateTime.month,
                                      _selectedDateTime.day,
                                      pickedTime.hour,
                                      pickedTime.minute,
                                    );
                                    _updateControllerText();
                                    widget.onDateTimeSelected?.call();
                                  });
                                }
                              },
                            ),
                        ],
                      ),
                    ),
                    onChanged: _handleManualInput,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9\-: ]')),
                    ],
                  ),
                ],
              ),
            ),
            SeparadorAncho(size: widget.size, porcentaje: 2),
          ],
        ),
        SeparadorAltura(size: widget.size, porcentaje: 2),
      ],
    );
  }
}
