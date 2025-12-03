import 'package:flutter/material.dart';
import 'package:time_gate/pages/widgets_page/widgets_page.dart';
import 'package:time_gate/themes/app_theme.dart';
import 'package:time_gate/themes/custom_styles.dart';
import 'package:time_gate/utils/responsive_utils.dart';

class AttendanceCardDay extends StatelessWidget {

  final String checkin;
  final String checkout;
  final String pause;
  final String hoursworked;
  
  const AttendanceCardDay({
    super.key, required this.checkin, required this.checkout, required this.pause, required this.hoursworked,
  });

  @override
  Widget build(BuildContext context) {
    final titleOsw18Bold400Secondary = Theme.of(context).textTheme.titleOsw18Bold400Secondary;
    final fontSizedGrow = getResponsiveScaleFactor(context);
  
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 10, top: 10, right: 30, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const[
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  
                  children: [
                    Row( 
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      
                      children: [
                        Text('Viernes | 18/JUL/2025', style: titleOsw18Bold400Secondary.copyWith(fontSize: 18*fontSizedGrow),),
                        AttendanceTag(text: 'Asistencia', color: Colors.green)
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        _TimeCheck(hour: checkin, type: 'Check In',),
                        const SizedBox(width: 5,),
                        _TimeCheck(hour: checkout, type: 'Check Out',),
                        const SizedBox(width: 5,),
                        _TimeCheck(hour: pause, type: 'Pause',),
                        const SizedBox(width: 5,),
                        _TimeCheck(hour: hoursworked, type: 'Horas Trabajadas',)
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

class _TimeCheck extends StatelessWidget {
  final String hour;
  final String type;
  
  const _TimeCheck({
   required this.hour, required this.type
  });

  @override
  Widget build(BuildContext context) {

    final textJt14bold400Na = Theme.of(context).textTheme.textJt14bold400Na;
    final textOsw12bold500Primary = Theme.of(context).textTheme.textOsw12bold500Primary;
    final fontSizedGrow = getResponsiveScaleFactor(context);

    return Expanded(
      child: Column(
        
        children: [
          Text(hour, style: textJt14bold400Na.copyWith(
            fontSize: 14*fontSizedGrow,
            overflow: TextOverflow.ellipsis,
            fontWeight: type == 'Horas Trabajadas'
                        ? FontWeight.w900
                        : FontWeight.normal,
            color: type == 'Horas Trabajadas'
                        ? AppTheme.secondary
                        : Colors.grey
          ),
          ),
          const SizedBox(height: 5,),
          Text(type, style: textOsw12bold500Primary.copyWith(fontSize: 12*fontSizedGrow),overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}
