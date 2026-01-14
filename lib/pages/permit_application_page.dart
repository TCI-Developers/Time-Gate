import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  // Variables modificadas: Solo _startDate y se añade _selectedTime
  DateTime? _startDate;
  TimeOfDay? _selectedTime; // Nuevo: para guardar la hora seleccionada

  // Eliminamos _endDate y la lógica de rango de fechas de aquí.
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

  // Función para seleccionar la FECHA (simplificada para no tener rango)
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
        // Opcional: Establece la hora actual si no hay ninguna seleccionada
        _selectedTime ??= TimeOfDay.fromDateTime(now); 
      });
    }
  }

  // 🆕 Función para seleccionar la HORA
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay now = TimeOfDay.now();

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? now,
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
        // Opcional: Establece la fecha de hoy si no hay ninguna seleccionada
        _startDate ??= DateTime.now();
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final double maxContainerWidth = getMaxContentWidth(context);

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
                      // SELECTOR DE FECHA (DÍA)
                      Expanded(
                        child: GestureDetector(
                          //Se llama a la función de selección de fecha sin parámetros (versión única)
                          onTap: () => _selectDate(context), 
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Día', style: textOsw14bold500Primary),
                              const SizedBox(height: 8),
                              _buildDateBox(
                                text: _startDate != null
                                    ? _dateFormat.format(_startDate!)
                                    : 'Seleccionar día',
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      //SELECTOR DE HORA
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _selectTime(context), // Llama a la nueva función
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Hora', style: textOsw14bold500Primary),
                              const SizedBox(height: 8),
                              _buildDateBox(
                                text: _selectedTime != null
                                    ? _selectedTime!.format(context) // Muestra la hora formateada
                                    : 'Seleccionar hora',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // ReusableCalendar(
                  //   faltas: faltasAMostrar,
                  //   retardos: retardosAMostrar,
                  //   asistencias: asistenciasAMostrar,
                  //   rangeStart: inicioVacaciones,
                  //   rangeEnd: finVacaciones,
                  //   initialFocusedDay: DateTime(2025, 10, 12),
                  // ),
                  const SizedBox(height: 80),
                  Row(
                    children: [
                      Expanded(
                        child: ActionButton(
                            outlinedButton: false, 
                            title: 'Mandar', 
                            dateFormat: _dateFormat,
                            startDate: _startDate, 
                            selectedTime: _selectedTime,
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

// El widget _buildDateBox se mantiene sin cambios, es reutilizable para ambos
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
        color: AppTheme.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: TextStyle(fontSize: 13, color: disabled ? AppTheme.grey : AppTheme.secondary)),
          const Icon(Icons.keyboard_arrow_down, size: 30, color: AppTheme.secondary),
        ],
      ),
    );
  }
}