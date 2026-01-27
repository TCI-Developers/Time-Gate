import 'package:flutter/material.dart';
import 'package:time_gate/core/models/attendance_entry.dart';
import 'package:time_gate/core/models/attendance_stats.model.dart';
import 'package:time_gate/pages/widgets_page/widgets_page.dart';
import 'package:time_gate/utils/calendar_data.dart';

class AttendanceAttendanceSubage extends StatelessWidget {

  final List<AttendanceEntry> data;
  final AttendanceStats? stats;
  const AttendanceAttendanceSubage({super.key, required this.data, this.stats});

  @override
  Widget build(BuildContext context) {
   
    return Column(
      children: [
        Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    AttendanceCard( 
                      color: Colors.red, type: 'Retardos', 
                      maxProgress: (stats?.retardosPermitidos ?? 1).toDouble(), 
                      currentProgress: (stats?.retardosTomados ?? 0).toDouble(),
                    ),
                    const SizedBox(height: 10,),
                    AttendanceCard(
                      color: kColorSeleccionado, type: 'Permisos', 
                      maxProgress: (stats?.permisosPermitidos ?? 1).toDouble(), 
                      currentProgress: (stats?.permisosTomados ?? 0).toDouble(),
                    ),
                    const SizedBox(height: 10,),
                    AttendanceCard(
                      color: Colors.orange, type: 'Vacaciones', 
                      maxProgress: (stats?.totalVacaciones ?? 1).toDouble(),
                      currentProgress: (stats?.vacacionesTomadas ?? 0).toDouble(), 
                    ), 
                  ],
                ),
              ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: Column(
                      children: [
                        MonthlyRegistrationCard(
                          asistencia: stats?.diasTrabajados ?? 0,
                          vacaciones: stats?.vacacionesTomadas ?? 0,
                          ausencias: stats?.totalAusencias ?? 0,
                          asistenciasMensuales: stats?.asistenciasMensuales ?? 0,
                          totalVacaciones: stats?.totalVacaciones ?? 1,
                          ausenciasPermitidas: stats?.ausenciasPermitidas ?? 0,
                        )
                      ],
                    ),
                  )
                
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              AttendanceCardTwo(
                  color: const Color.fromARGB(255, 59, 139, 62), type: 'Asistencias', 
                  maxProgress: stats?.asistenciasMensuales ?? 1, 
                  currentProgress: stats?.diasTrabajados ?? 0.0,
                  text: 'de trabajo ordinario',
                  horas: stats?.totalTrabajado ?? '0',
              ),
              const SizedBox(width: 10,),
              AttendanceCardTwo(
                color: const Color.fromARGB(255, 197, 52, 42), 
                type: 'Ausencias', 
                maxProgress: stats?.ausenciasPermitidas?.toDouble() ?? 1, 
                currentProgress: stats?.totalAusencias ?? 1, 
                text: 'horas de retraso',
                horas: stats?.totalHorasAusencias ?? '0',
              ),    
            ],
          ),
          const SizedBox(height: 20,),
          AttendanceResumeCard(
            hoursWorked: stats?.totalTrabajado.toString() ?? '0', 
            leaveHours: stats?.horasPermisos.toString() ?? '0', 
            overtime: stats?.horasExtra.toString() ?? '0', 
            daysWorked: stats?.diasTrabajados?.toInt() ?? 0, 
            leaveDays: stats?.permisosTomados?.toInt() ?? 0, 
            extraDays: stats?.diasExtra?.toInt() ?? 0,
          ),
          const SizedBox(height: 20,),
          if (data.isEmpty)
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('No hay registros disponibles para este mes'),
            )
          else
            ...data.map((entry) => Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: AttendanceCardDay(
                // 1. Usamos checkIn y checkOut del modelo
                checkin: entry.checkIn ?? '--:--', 
                checkout: entry.checkOut ?? '--:--',
                
                // 2. Convertimos la lista de pausas a un solo String separado por guiones
                pause: (entry.pause ?? []).isEmpty ? 'Sin pausas' : entry.pause!.join(' - '),
                
                // 3. Usamos totalTrabajado (el dynamic lo pasamos a String)
                hoursworked: entry.totalTrabajado?.toString() ?? '0h 00m',
                
                // 4. Si tu widget AttendanceCardDay tiene campo para fecha o día:
                date: "${entry.day} | ${entry.date}", 

                type: (entry.type == null || entry.type == "") ? 'por definir' : entry.type ?? '',
              ),
            )),
      ],
    );
  }
}