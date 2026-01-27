import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:time_gate/core/models/attendance_stats.model.dart';
import 'package:time_gate/providers/attendance_provider.dart';
import 'package:time_gate/themes/app_theme.dart';
import 'package:time_gate/themes/custom_styles.dart';
import 'package:time_gate/utils/responsive_utils.dart';
import 'package:time_gate/widgets/widgets.dart';

class VacationRequestPage extends StatefulWidget {
  const VacationRequestPage({super.key});

  @override
  State<VacationRequestPage> createState() => _VacationRequestPageState();
}

class _VacationRequestPageState extends State<VacationRequestPage> {

  DateTime? _startDate;
  DateTime? _endDate;
  DateTime _focusedDay = DateTime.now(); 
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

   static const List<DateTime> faltasAMostrar = [];
   static const List<DateTime> retardosAMostrar = [];
   static const List<DateTime> asistenciasAMostrar = [];

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
      type: 'vacaciones', 
      month: _focusedDay.month,
      year: _focusedDay.year,
    );

  }
  
  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);

    final DateTime firstDate = isStart ? today : (_startDate ?? today);
    final DateTime lastDate = DateTime(now.year + 2);

    DateTime initialDate = isStart ? (_startDate ?? today) : (_endDate ?? _startDate ?? today);

    if (initialDate.isBefore(firstDate)) {
      initialDate = firstDate;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate, 
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          _focusedDay = picked;
          if (_endDate != null && _endDate!.isBefore(picked)) {
            _endDate = null;
          }
        } else {
          _endDate = picked;
          _focusedDay = picked;
        }
      });
    }
  }

Future<void> _onSend() async {
  if (_startDate == null || _endDate == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Por favor, selecciona el rango completo')),
    );
    return;
  }

  final bool? confirm = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Confirmar solicitud'),
      content: const Text('¿Estás seguro de que quieres solicitar estas fechas?'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: const Text('Cancelar')),
        TextButton(onPressed: () => Navigator.pop(dialogContext, true), child: const Text('Sí, solicitar')),
      ],
    ),
  );

  if (!mounted || confirm != true) return;

  final provider = context.read<AttendanceProvider>();
  final navigator = Navigator.of(context); 

  final bool ok = await provider.sendVacationRequest(
    startDate: _startDate!,
    endDate: _endDate!,
  );

  if (!mounted) return;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) => AlertDialog(
      title: Text(ok ? 'Éxito' : 'Error'),
      content: Text(ok ? (provider.successMessage ?? 'Enviado') : (provider.errorMessage ?? 'Error')),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(dialogContext);
            if (ok) {
              navigator.pop(); 
              _fetchAttendance();
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
    
    final vacacionesYaAprobadas = stats?.fechaVacaciones ?? [];

    final double maxContainerWidth = getMaxContentWidth(context);
    final textOsw14bold500Primary = Theme.of(context).textTheme.textOsw14bold500Primary;

    final fontSizedGrow = getResponsiveScaleFactor(context);
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
                  const HeaderRequest(title: 'Solicitud \n de Vacaciones'),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      // FECHA DESDE
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _selectDate(context, true),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Desde', style: textOsw14bold500Primary.copyWith(fontSize: 14*fontSizedGrow)),
                              const SizedBox(height: 8),
                              _buildDateBox(
                                text: _startDate != null
                                    ? _dateFormat.format(_startDate!)
                                    : 'Seleccionar fecha',
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),

                      // FECHA HASTA
                      Expanded(
                        child: GestureDetector(
                          onTap: _startDate == null
                              ? () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Selecciona primero la fecha "Desde"'),
                                    ),
                                  );
                                }
                              : () => _selectDate(context, false),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Hasta', style: textOsw14bold500Primary.copyWith(fontSize: 14*fontSizedGrow)),
                              const SizedBox(height: 8),
                              _buildDateBox(
                                text: _endDate != null
                                    ? _dateFormat.format(_endDate!)
                                    : 'Seleccionar fecha',
                                disabled: _startDate == null,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ReusableCalendar(
                    key: ValueKey('vac-cal-${_focusedDay.month}-${_startDate != null}'),
                    faltas: faltasAMostrar,
                    retardos: retardosAMostrar,
                    asistencias: asistenciasAMostrar,
                    rangeStart: _startDate,
                    rangeEnd: _endDate,
                    vacacionesRangos: vacacionesYaAprobadas,
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
                          onTap: isLoading ? null : _onSend,// <--- Aquí pasas la lógica
                        )
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: ActionButton(
                          outlinedButton: true, 
                          title: 'Cancelar',
                          onTap: () => Navigator.pop(context), // <--- El botón de cancelar solo hace pop
                        )
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
        
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: TextStyle(fontSize: 13, color: disabled ? Colors.grey : AppTheme.secondary)),
          const Icon(Icons.keyboard_arrow_down, size: 30, color: AppTheme.secondary),
        ],
      ),
    );
  }
}


