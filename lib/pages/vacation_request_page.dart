import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  final List<DateTime> faltasAMostrar = [
    DateTime(2025, 11, 15), 
    DateTime(2025, 11, 22)
  ];

  final List<DateTime> retardosAMostrar = [
    DateTime(2025, 11, 16), 
    DateTime(2025, 11, 23)
  ];

  final List<DateTime> asistenciasAMostrar = [
    DateTime(2025, 11, 17), 
    DateTime(2025, 11, 24)
  ];

  final DateTime? inicioVacaciones = DateTime(2025, 11, 1);

  final DateTime? finVacaciones = DateTime(2025, 11, 10);


  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime now = DateTime.now();

    // límites dinámicos
    final DateTime firstDate =
        isStart ? DateTime(now.year - 1) : (_startDate ?? DateTime(now.year - 1));
    final DateTime lastDate =
        isStart ? (_endDate ?? DateTime(now.year + 2)) : DateTime(now.year + 2);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart
          ? (_startDate ?? now)
          : (_endDate ?? _startDate ?? now),
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          // Si la fecha final es anterior, la borramos
          if (_endDate != null && _endDate!.isBefore(picked)) {
            _endDate = null;
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    faltas: faltasAMostrar,
                    retardos: retardosAMostrar,
                    asistencias: asistenciasAMostrar,
                    rangeStart: inicioVacaciones,
                    rangeEnd: finVacaciones,
                    initialFocusedDay: DateTime(2025, 10, 12),
                  ),
                  const SizedBox(height: 80),
                  Row(
                    children: [
                      Expanded(
                        child: ActionButton(
                            outlinedButton: false, 
                            title: 'Mandar', 
                            dateFormat: _dateFormat,
                            startDate: _startDate, 
                            endDate: _endDate,
                          )
                        ),
                      SizedBox(width: 15,),
                      Expanded(
                        child: ActionButton(
                            outlinedButton: true, 
                            title: 'Cancelar',
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


