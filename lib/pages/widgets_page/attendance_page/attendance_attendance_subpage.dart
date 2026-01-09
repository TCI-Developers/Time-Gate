import 'package:flutter/material.dart';
import 'package:time_gate/core/models/attendance_entry.dart';
import 'package:time_gate/core/models/attendance_status.model.dart';
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
                      maxProgress: stats?.retardosPermitidos ?? 1, 
                      currentProgress: stats?.retardosTomados ?? 0.0,
                    ),
                    const SizedBox(height: 10,),
                    AttendanceCard(
                      color: kColorSeleccionado, type: 'Permisos', 
                      maxProgress: stats?.permisosPermitidos ?? 1, 
                      currentProgress: stats?.permisosTomados ?? 0.0,
                    ),
                    const SizedBox(height: 10,),
                    AttendanceCard(
                      color: Colors.orange, type: 'Vacaciones', 
                      maxProgress: stats?.totalVacaciones ?? 1, 
                      currentProgress: stats?.vacacionesTomadas ?? 0.0, 
                    ), 
                  ],
                ),
              ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: Column(
                      children: [
                        MonthlyRegistrationCard()
                      ],
                    ),
                  )
                
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              AttendanceCardTwo(
                  color: Colors.red, type: 'Asistencias', 
                  maxProgress: stats?.asistenciasMensuales ?? 1, 
                  currentProgress: stats?.diasTrabajados ?? 0.0,
                  text: 'de trabajo ordinario',
              ),
              const SizedBox(width: 10,),
              AttendanceCardTwo(
                color: Colors.red, 
                type: 'Ausencias', 
                maxProgress: 10, 
                currentProgress: stats?.totalAusencias ?? 1, 
                text: 'horas de retraso',
              ),    
            ],
          ),
          const SizedBox(height: 20,),
          AttendanceResumeCard(
            hoursWorked: '', 
            leaveHours: stats?.horasPermisos ??'', 
            overtime: stats?.horasExtra ?? '', 
            daysWorked: stats?.diasTrabajados.toString() ?? '', 
            leaveDays: stats?.permisosTomados.toString() ?? '', 
            extraDays: '',
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
                pause: entry.pause.isEmpty ? 'Sin pausas' : entry.pause.join(' - '),
                
                // 3. Usamos totalTrabajado (el dynamic lo pasamos a String)
                hoursworked: entry.totalTrabajado?.toString() ?? '0h 00m',
                
                // 4. Si tu widget AttendanceCardDay tiene campo para fecha o día:
                // date: "${entry.day} ${entry.date}", 
              ),
            )),
      ],
    );
  }
}