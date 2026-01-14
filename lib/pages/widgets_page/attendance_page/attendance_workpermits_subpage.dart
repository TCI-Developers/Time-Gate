import 'package:flutter/material.dart';
import 'package:time_gate/core/models/attendance_status.model.dart';
import 'package:time_gate/pages/widgets_page/attendance_page/attendance_vacation_card.dart';
import 'package:time_gate/pages/widgets_page/attendance_page/attendance_vacation_status_card.dart';
import 'package:time_gate/themes/custom_styles.dart';

class AttendanceWorkpermitsSubpage extends StatelessWidget {
  final AttendanceStats? stats;
  const AttendanceWorkpermitsSubpage({super.key, this.stats});


  @override
  Widget build(BuildContext context) {
    final titleOsw24Bold500Secondary = Theme.of(context).textTheme.titleOsw24Bold500Secondary;
    // print('stats desde la verga perro secrum $stats');
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
        SizedBox(
          width: double.infinity,
          child: AttendanceVacationStatusCard(vacationRange: '11/Jul/2025 al 15/Jul/2025', status: 'Aprobado',type: 'Exámenes médicos',),
        )
      ],
    );
  }
}