import 'package:flutter/material.dart';
import 'package:time_gate/core/models/attendance_entry.dart';
import 'package:time_gate/core/models/attendance_stats.model.dart';
import 'package:time_gate/pages/widgets_page/attendance_page/attendance_vacation_status_card.dart';
import 'package:time_gate/pages/widgets_page/widgets_page.dart';
import 'package:time_gate/themes/custom_styles.dart';
import 'package:time_gate/utils/responsive_utils.dart';

class AttendanceVacationSubage extends StatelessWidget {

  final AttendanceStats? stats;
  final List<AttendanceEntry>? data;
  const AttendanceVacationSubage({super.key, this.stats, required this.data, });

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
        

        if (data!.isEmpty)
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



