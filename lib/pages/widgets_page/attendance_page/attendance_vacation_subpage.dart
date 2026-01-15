import 'package:flutter/material.dart';
import 'package:time_gate/core/models/attendance_stats.model.dart';
import 'package:time_gate/pages/widgets_page/attendance_page/attendance_vacation_status_card.dart';
import 'package:time_gate/pages/widgets_page/widgets_page.dart';
import 'package:time_gate/themes/custom_styles.dart';
import 'package:time_gate/utils/responsive_utils.dart';

class AttendanceVacationSubage extends StatelessWidget {

  final AttendanceStats? stats;
  const AttendanceVacationSubage({super.key, this.stats});

  @override
  Widget build(BuildContext context) {
    final titleOsw24Bold500Secondary = Theme.of(context).textTheme.titleOsw24Bold500Secondary;
    final fontSizedGrow = getResponsiveScaleFactor(context);
    
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            
            children: [
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text('Días de Vacaciones', style: titleOsw24Bold500Secondary.copyWith(fontSize: 24*fontSizedGrow),)
              ),
              const SizedBox(height: 10,),
              AttendanceVacationCard( 
                totalDays: (stats?.totalVacaciones ?? 0).toInt().toString(), 
                usedDays: (stats?.vacacionesTomadas ?? 0).toInt().toString(), 
                remainingDays: ((stats?.totalVacaciones ?? 0).toInt() - (stats?.vacacionesTomadas ?? 0).toInt()).toString() , 
                buttonTitle: 'Solicitar Vacaciones',
              ), 
            ],
          ),
        ),
        const SizedBox(height: 20,),
        SizedBox(
          width: double.infinity,
          child: AttendanceVacationStatusCard(vacationRange: '11/Jul/2025 al 15/Jul/2025', status: 'Aprobado', type: 'Vacaciones',),
        )
      ],
    );
  }
}



