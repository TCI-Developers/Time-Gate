import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
// import 'package:time_gate/core/models/attendance_status.model.dart';
import '../utils/calendar_data.dart'; // Importa tus constantes
import 'package:intl/intl.dart';
// Esta clase auxiliar contendrá toda la lógica de renderizado visual.
class CustomCalendarBuilders {
  final List<DateTime> faltas;
  final List<DateTime> retardos;
  final List<DateTime> asistencias;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  // final List<VacacionRango> vacaciones;

  CustomCalendarBuilders({
    required this.faltas,
    required this.retardos,
    required this.asistencias,
    this.rangeStart,
    this.rangeEnd,
    // required this.vacaciones,
  });
  
  // Función auxiliar para verificar si un día tiene una marca
  bool _isMarkedDay(DateTime day, List<DateTime> marks) {
    return marks.any((markedDay) => isSameDay(day, markedDay));
  }

  // Widget auxiliar para crear el punto de marca (pequeño círculo)
  Widget _buildMarker(Color color) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }

 
  CalendarBuilders get builders => CalendarBuilders(
    
    dowBuilder: (context, day) {
        
        final String text = DateFormat.E('es_ES').format(day);
        
  
        final String dayLabel = text.substring(0, 1).toUpperCase();

        return Center(
            child: Text(
                dayLabel,
                // El TextStyle será ignorado si el daysOfWeekStyle está definido,
                // pero lo ponemos por seguridad.
                style: const TextStyle(fontWeight: FontWeight.bold), 
            ),
        );
    },
  
    rangeStartBuilder: (context, day, focusedDay) {
      final screenWidth = MediaQuery.of(context).size.width;
      if (isSameDay(day, rangeStart)) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: screenWidth > 450 ? 6 : 12),
          decoration: const BoxDecoration(
            color: kColorVacaciones,
         
            borderRadius: BorderRadius.horizontal(left: Radius.circular(100)),
          ),
          alignment: Alignment.center,
          child: Text(
            '${day.day}',
            style: const TextStyle(color: Colors.black),
          ),
        );
      }
      return null;
    },

    
    rangeEndBuilder: (context, day, focusedDay) {
      final screenWidth = MediaQuery.of(context).size.width;
      
      if (isSameDay(day, rangeEnd)) {
        return Container(
         
          margin: EdgeInsets.symmetric(vertical: screenWidth > 450 ? 6 : 12),
          decoration: const BoxDecoration(

            color: kColorVacaciones,
            
            borderRadius: BorderRadius.horizontal(right: Radius.circular(100)),
          ),
          alignment: Alignment.center,
          child: Text(
            '${day.day}',
            style: const TextStyle(color: Colors.black),
          ),
        );
      }
      return null;
    },
    // prioritizedBuilder: (context, day, focusedDay) {
    //   final screenWidth = MediaQuery.of(context).size.width;
      
    //   for (var rango in vacaciones) {
    //     // Normalizamos fechas para comparar solo día/mes/año
    //     final d = DateTime(day.year, day.month, day.day);
    //     final s = DateTime(rango.inicio.year, rango.inicio.month, rango.inicio.day);
    //     final e = DateTime(rango.fin.year, rango.fin.month, rango.fin.day);

    //     bool isStart = isSameDay(d, s);
    //     bool isEnd = isSameDay(d, e);
    //     bool isInRange = d.isAfter(s) && d.isBefore(e);

    //     if (isStart || isEnd || isInRange) {
    //       return Container(
    //         margin: EdgeInsets.symmetric(vertical: screenWidth > 450 ? 6 : 12),
    //         decoration: BoxDecoration(
    //           color: kColorVacaciones,
    //           borderRadius: BorderRadius.only(
    //             topLeft: isStart ? const Radius.circular(100) : Radius.zero,
    //             bottomLeft: isStart ? const Radius.circular(100) : Radius.zero,
    //             topRight: isEnd ? const Radius.circular(100) : Radius.zero,
    //             bottomRight: isEnd ? const Radius.circular(100) : Radius.zero,
    //           ),
    //         ),
    //         alignment: Alignment.center,
    //         child: Text(
    //           '${day.day}',
    //           style: const TextStyle(color: Colors.black),
    //         ),
    //       );
    //     }
    //   }
    //   return null; // Si no es rango de vacación, sigue a los demás builders
    // },
    
    defaultBuilder: (context, day, focusedDay) {
      
   
      bool isDayInVacationRange = (rangeStart != null && rangeEnd != null && 
                                 (day.isAfter(rangeStart!) || isSameDay(day, rangeStart!)) && 
                                 (day.isBefore(rangeEnd!) || isSameDay(day, rangeEnd!)));

      if (isDayInVacationRange) {
          return null;
      }
      
      // 2. Definición de las marcas
      bool isFalta = _isMarkedDay(day, faltas);
      bool isRetardo = _isMarkedDay(day, retardos);
      bool isAsistencia = _isMarkedDay(day, asistencias);
      
      if (!isFalta && !isRetardo && !isAsistencia) {
        return null;
      }

      if (isAsistencia) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              // Usamos kColorSeleccionado (Azul) para el relleno
              color: kColorSeleccionado, 
              shape: BoxShape.circle,
            ),
            child: Text(
              '${day.day}',
              // Texto en blanco para contraste sobre el fondo azul
              style: const TextStyle(color: Colors.white), 
            ),
          );
      }

      if (isRetardo) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              // Usamos kColorBordeMarcado (Rojo Oscuro) para el borde
              border: Border.all(color: kColorBordeMarcado, width: 2), 
              shape: BoxShape.circle,
            ),
            child: Text(
              '${day.day}',
              style: const TextStyle(color: Colors.black),
            ),
          );
      }

      if (isFalta) {
          return Stack(
            alignment: Alignment.center,
            children: [
              // Pinta el número del día en el centro (solo texto)
              Container(
                  alignment: Alignment.center,
                  child: Text(
                    '${day.day}',
                    style: const TextStyle(color: Colors.black),
                  ),
              ),
              // Punto indicador (Solo Falta)
              Positioned(
                  bottom: 2,
                  child: _buildMarker(kColorFalta), 
              ),
            ],
          );
      }
      return null;
      
      
    },

    
  );
}
