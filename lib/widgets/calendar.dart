import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:time_gate/themes/app_theme.dart';
import 'package:time_gate/themes/custom_styles.dart';
import 'package:time_gate/utils/responsive_utils.dart';
import '../utils/calendar_data.dart'; 
import 'custom_calendar_builders.dart'; 

// Componente Stateful para manejar el mes visible
class ReusableCalendar extends StatefulWidget {
  
  // ➡️ PARÁMETROS DE ENTRADA
  final List<DateTime>? faltas;
  final List<DateTime>? retardos;
  final List<DateTime>? asistencias;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  final DateTime? initialFocusedDay;
  
  const ReusableCalendar({
    super.key,
    this.faltas,
    this.retardos,
    this.asistencias,
    this.rangeStart,
    this.rangeEnd,
    this.initialFocusedDay,
  });
  
  @override
  State<ReusableCalendar> createState() => _ReusableCalendarState();
}


class _ReusableCalendarState extends State<ReusableCalendar> {
  
  // ESTADO MUTABLE
  late DateTime _focusedDay;

  // Constantes de clase
  static final DateTime _firstDay = DateTime.utc(2023, 1, 1);
  static final DateTime _lastDay = DateTime.utc(2030, 12, 31);
  
  @override
  void initState() {
    super.initState();
    // 🚨 Inicia en el día provisto, el inicio del rango, o el mes actual (DateTime.now())
    DateTime initial = widget.initialFocusedDay ?? widget.rangeStart ?? DateTime.now();
    _focusedDay = DateTime(initial.year, initial.month, 1);
  }

  // Lógica de Generación de Meses
  List<DateTime> _generarMeses() {
    List<DateTime> meses = [];
    DateTime mesActual = DateTime(_firstDay.year, _firstDay.month, 1);
    DateTime limite = DateTime(_lastDay.year, _lastDay.month, 1);

    while (mesActual.isBefore(limite) || mesActual.isAtSameMomentAs(limite)) {
      meses.add(mesActual);
      mesActual = DateTime(mesActual.year, mesActual.month + 1, 1);
    }
    return meses;
  }
  
  // HANDLER para el Dropdown del mes
  void _onMonthChanged(DateTime? newMonth) {
    if (newMonth != null) {
      setState(() {
        // Mantiene el día en 1
        _focusedDay = newMonth; 
      });
    }
  }

  // HANDLER para la navegación con swipe o flechas del TableCalendar
  void _onPageChanged(DateTime newFocusedDay) {
    if (_focusedDay.year != newFocusedDay.year || _focusedDay.month != newFocusedDay.month) {
        setState(() {
            // Establece el nuevo mes enfocado, manteniendo el día en 1
            _focusedDay = DateTime(newFocusedDay.year, newFocusedDay.month, 1);
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    
    // Asigna datos seguros
    final List<DateTime> safeFaltas = widget.faltas ?? [];
    final List<DateTime> safeRetardos = widget.retardos ?? [];
    final List<DateTime> safeAsistencias = widget.asistencias ?? [];
    
    final List<DateTime> mesesDisponibles = _generarMeses();

    final calendarBuilders = CustomCalendarBuilders(
      rangeStart: widget.rangeStart,
      rangeEnd: widget.rangeEnd,
      faltas: safeFaltas,
      retardos: safeRetardos,
      asistencias: safeAsistencias,
    );

    final titleOsw24Bold500Secondary = Theme.of(context).textTheme.titleOsw24Bold500Secondary;
    final fontSizedGrow = getResponsiveScaleFactor(context);
    
    return Card(
      color: AppTheme.white,
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Column( 
          mainAxisSize: MainAxisSize.min,
          children: [
      
            Container(
              decoration: const BoxDecoration(
                color: kColorCabecera, 
                borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<DateTime>(
                    
                    value: mesesDisponibles.firstWhere(
                      (m) => m.year == _focusedDay.year && m.month == _focusedDay.month,
                      orElse: () => mesesDisponibles.first,
                    ),
                    dropdownColor: kColorCabecera, 
                    style: const TextStyle(color: AppTheme.white, fontSize: 16),
                    icon: const Icon(Icons.arrow_drop_down_sharp, color: AppTheme.white),
                    underline: const SizedBox.shrink(),
                   
                    items: mesesDisponibles.map((DateTime mes) {
                      String nombreMes = DateFormat.yMMMM('es_ES').format(mes); 
                      return DropdownMenuItem<DateTime>(
                        value: mes,
                        child: Text(nombreMes[0].toUpperCase() + nombreMes.substring(1), style: titleOsw24Bold500Secondary.copyWith(fontWeight: FontWeight.bold, color: AppTheme.white, fontSize: 15*fontSizedGrow),),
                      );
                    }).toList(),
                    
                    
                    onChanged: _onMonthChanged, 
                  ),
                ],
              ),
            ),
   
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TableCalendar(
                
                locale: 'es_ES',
                headerVisible: false,
                firstDay: _firstDay,
                lastDay: _lastDay,
                focusedDay: _focusedDay, // Usa el estado
                
                rangeStartDay: widget.rangeStart,
                rangeEndDay: widget.rangeEnd,
                rangeSelectionMode: RangeSelectionMode.toggledOff,
            
                // Handlers nulos para evitar interacción
                onDaySelected: null,
                onRangeSelected: null,
                selectedDayPredicate: (day) => false, 
                
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(color: AppTheme.black, fontWeight: FontWeight.bold),
                  weekendStyle: TextStyle(color: AppTheme.black, fontWeight: FontWeight.bold),
                
                ),
                
                
                calendarStyle:  CalendarStyle( 
                    defaultTextStyle: TextStyle(color: AppTheme.black), 
                    weekendTextStyle: TextStyle(color: Colors.black54),
                    outsideTextStyle: TextStyle(color: AppTheme.grey),
                    rangeHighlightColor: kColorVacaciones,
                    rangeHighlightScale: 1,
                    todayDecoration: BoxDecoration(
                      color: null,
                      
                    ),
                    todayTextStyle: TextStyle(color: AppTheme.black),
                ),
                
                calendarFormat: CalendarFormat.month,
                
                onFormatChanged: null,
                
                onPageChanged: _onPageChanged, 

                calendarBuilders: calendarBuilders.builders,
              ),
            ),
          ],
        ),
    );
  }
}