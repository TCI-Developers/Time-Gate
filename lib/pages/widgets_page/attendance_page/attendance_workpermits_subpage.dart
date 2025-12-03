import 'package:flutter/material.dart';
import 'package:time_gate/pages/widgets_page/attendance_page/attendance_vacation_card.dart';
import 'package:time_gate/pages/widgets_page/attendance_page/attendance_vacation_status_card.dart';
import 'package:time_gate/themes/custom_styles.dart';

class AttendanceWorkpermitsSubpage extends StatelessWidget {
  const AttendanceWorkpermitsSubpage({super.key});

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
              AttendanceVacationCard( totalDays: '12 permisos', usedDays: '5 permisos', remainingDays: '7 permisos', buttonTitle: 'Solicitar Permiso',), 
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