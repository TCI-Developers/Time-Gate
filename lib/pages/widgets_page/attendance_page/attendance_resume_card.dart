import 'package:flutter/material.dart';
import 'package:time_gate/themes/app_theme.dart';
import 'package:time_gate/themes/custom_styles.dart';
import 'package:time_gate/utils/responsive_utils.dart';

class AttendanceResumeCard extends StatelessWidget {
  
  final String hoursWorked;
  final String leaveHours;
  final String overtime;
  final int? daysWorked;
  final int? leaveDays;
  final int? extraDays;

  const AttendanceResumeCard({super.key, required this.hoursWorked, required this.leaveHours, required this.overtime, required this.daysWorked, required this.leaveDays, required this.extraDays});
  
  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xffe5e5e5),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _CheckTime(title: 'Horas Trabajadas', text: hoursWorked, border: false),
              _CheckTime(title: 'Horas de Permiso', text: leaveHours, border: true),
              _CheckTime(title: 'Horas Extra', text: overtime, border: false),
            ],
          ),
          const SizedBox(height: 20,),
          Container(
            width: double.infinity,
            height: 2,
            color: AppTheme.secondary,
            margin: const EdgeInsets.symmetric(horizontal:15 ),
          ),
          const SizedBox(height: 20,),
          Row(
            children: [
              _CheckTime(title: 'Días Trabajados', text: daysWorked.toString(), border: false),
              _CheckTime(title: 'Días de Permiso', text: leaveDays.toString(), border: true),
              _CheckTime(title: 'Días Extra', text: extraDays.toString(), border: false),
            ],
          ),
        ],
      ),

      
    );
  }
}



class _CheckTime extends StatelessWidget {

  final String title;
  final String text;
  final bool border;

  const _CheckTime({
    required this.title, required this.text, required this.border,
  });

  @override
  Widget build(BuildContext context) {
    final textOsw12boldPrimary = Theme.of(context).textTheme.textOsw12boldPrimary;
    final titleJt20Bold500Secondary = Theme.of(context).textTheme.titleJt20Bold500Secondary;

    final fontSizedGrow = getResponsiveScaleFactor(context);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: border
            ? const BoxDecoration(
                border: Border.symmetric(
                  vertical: BorderSide(width: 2, color: Colors.white),
                ),
              )
            : null,
        child: Column(
         
          children: [
            Text(
              title,
              style: textOsw12boldPrimary.copyWith(fontSize: 12*fontSizedGrow),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5,),
            Text(
              text,
              style: titleJt20Bold500Secondary.copyWith(fontSize: 20*fontSizedGrow),
              softWrap: true,              
              textAlign: TextAlign.center, 
            ),
          ],
        ),
      ),
    );
  }
}