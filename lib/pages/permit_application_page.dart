import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:time_gate/core/models/attendance_stats.model.dart';
import 'package:time_gate/providers/attendance_provider.dart';
import 'package:time_gate/themes/app_theme.dart';
import 'package:time_gate/themes/custom_styles.dart';
import 'package:time_gate/utils/responsive_utils.dart';
import 'package:time_gate/widgets/widgets.dart';

class PermitApplicationPage extends StatefulWidget {
  const PermitApplicationPage({super.key});

  @override
  State<PermitApplicationPage> createState() => _PermitApplicationPageState();
}

class _PermitApplicationPageState extends State<PermitApplicationPage> {
  DateTime? _startDate;
  TimeOfDay? _selectedTime;
  DateTime _focusedDay = DateTime.now();
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchAttendance();
    });
  }

  void _fetchAttendance() {
    final attendanceProv = context.read<AttendanceProvider>();
    if (!mounted || attendanceProv.isLoading) return;

    attendanceProv.loadAttendance(
      type: 'permisos',
      month: _focusedDay.month,
      year: _focusedDay.year,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 2),
    );

    if (picked != null) {
      setState(() {
        _startDate = picked;
        _focusedDay = picked;
        _selectedTime ??= TimeOfDay.fromDateTime(now);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay now = TimeOfDay.now();
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? now,
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
        _startDate ??= DateTime.now();
      });
    }
  }

  Future<void> _onSend() async {
    if (_startDate == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, selecciona fecha y hora')),
      );
      return;
    }

    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Confirmar permiso'),
        content: const Text('¿Deseas enviar esta solicitud de permiso?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: const Text('Cancelar')),
          TextButton(onPressed: () => Navigator.pop(dialogContext, true), child: const Text('Confirmar')),
        ],
      ),
    );

    if (!mounted || confirm != true) return;

    final provider = context.read<AttendanceProvider>();
    final navigator = Navigator.of(context);

    final DateTime fullDateTime = DateTime(
      _startDate!.year,
      _startDate!.month,
      _startDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    final bool ok = await provider.sendPermitRequest(
      date: fullDateTime,
    );

    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: Text(ok ? 'Éxito' : 'Error'),
        content: Text(ok ? (provider.successMessage ?? 'Solicitud enviada') : (provider.errorMessage ?? 'Error al enviar')),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              if (ok){
                _fetchAttendance();
                navigator.pop();
              }
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<AttendanceProvider, bool>((p) => p.isLoading);
    final stats = context.select<AttendanceProvider, AttendanceStats?>((p) => p.stats);

    final List<DateTime> fechasYaSolicitadas = (stats?.fechaPermisos ?? [])
        .map((fechaStr) => DateTime.parse(fechaStr))
        .toList();

    final fontSizedGrow = getResponsiveScaleFactor(context);
    final maxContainerWidth = getMaxContentWidth(context);
    final textOsw14bold500Primary = Theme.of(context).textTheme.textOsw14bold500Primary;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 30),
          child: Center(
            child: Container(
              width: maxContainerWidth,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderRequest(title: 'Solicitud \n de Permiso'),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _selectDate(context),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Día', style: textOsw14bold500Primary.copyWith(fontSize: 14 * fontSizedGrow)),
                              const SizedBox(height: 8),
                              _buildDateBox(
                                text: _startDate != null ? _dateFormat.format(_startDate!) : 'Seleccionar día',
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _selectTime(context),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Hora', style: textOsw14bold500Primary.copyWith(fontSize: 14 * fontSizedGrow)),
                              const SizedBox(height: 8),
                              _buildDateBox(
                                text: _selectedTime != null ? _selectedTime!.format(context) : 'Seleccionar hora',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ReusableCalendar(
                    key: ValueKey('perm-cal-${_focusedDay.month}-${_startDate != null}'),
                    faltas: const [], 
                    retardos: const [],
                    asistencias: fechasYaSolicitadas,
                    rangeStart: _startDate,
                    rangeEnd: _startDate,
                    vacacionesRangos: stats?.fechaVacaciones ?? [],
                    initialFocusedDay: _focusedDay,
                    onPageChanged: (newDate) {
                      setState(() => _focusedDay = newDate);
                      _fetchAttendance();
                    },
                  ),
                  const SizedBox(height: 80),
                  Row(
                    children: [
                      Expanded(
                        child: ActionButton(
                          outlinedButton: false,
                          title: isLoading ? 'Enviando...' : 'Mandar',
                          onTap: isLoading ? null : _onSend,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: ActionButton(
                          outlinedButton: true,
                          title: 'Cancelar',
                          onTap: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateBox({required String text, bool disabled = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                color: disabled ? Colors.grey : AppTheme.secondary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Icon(Icons.keyboard_arrow_down, size: 30, color: AppTheme.secondary),
        ],
      ),
    );
  }
}