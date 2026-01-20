import 'package:flutter/material.dart';
import 'package:time_gate/core/models/attendance_entry.dart';
import 'package:time_gate/core/models/attendance_stats.model.dart';
import 'package:time_gate/pages/widgets_page/attendance_page/attendance_vacation_card.dart';
import 'package:time_gate/pages/widgets_page/attendance_page/attendance_vacation_status_card.dart';
// import 'package:time_gate/pages/widgets_page/attendance_page/attendance_vacation_status_card.dart';
import 'package:time_gate/themes/custom_styles.dart';

class AttendanceWorkpermitsSubpage extends StatelessWidget {
  final AttendanceStats? stats;
  final List<AttendanceEntry>? data;
  const AttendanceWorkpermitsSubpage({super.key, this.stats, this.data});


  @override
  Widget build(BuildContext context) {
    final titleOsw24Bold500Secondary = Theme.of(context).textTheme.titleOsw24Bold500Secondary;
    
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            
            children: [
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text('Permisos', style: titleOsw24Bold500Secondary,)
              ),
              const SizedBox(height: 10,),
              AttendanceVacationCard( 
                totalDays: '${(stats?.permisosPermitidos ?? 0).toInt().toString()} permisos', 
                usedDays: '${(stats?.permisosTomados ?? 0).toInt().toString()} permisos', 
                remainingDays: '${((stats?.permisosPermitidos ?? 0).toInt() - (stats?.permisosTomados ?? 0).toInt()).toString()} permisos' , 
                buttonTitle: 'Solicitar Permiso',
              ), 
            ],
          ),
        ),
        const SizedBox(height: 20,),
      
        if (data == null || data!.isEmpty)
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('No hay registros disponibles para este mes'),
            )
          else
            ...data!.map((entry) => Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: SizedBox(
                  width: double.infinity,
                  child: AttendanceVacationStatusCard(
                    vacationRange: entry.fechaRango ?? '--', 
                    status: entry.status ?? '---', 
                    type: entry.type ?? '--',
                    diasTomados: (entry.diasSolicitados).toString(),
                    totalDias: (entry.totalDias).toString(),
                  ),
                ),
            ),
            ),
      ],
    );
  }
}