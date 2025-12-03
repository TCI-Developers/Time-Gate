import 'package:flutter/material.dart';
import 'package:time_gate/themes/app_theme.dart';
import 'package:time_gate/themes/custom_styles.dart';
import 'package:time_gate/utils/responsive_utils.dart';

class AttendanceVacationStatusCard extends StatelessWidget {

  final String vacationRange;
  final String status;
  final String type;

  const AttendanceVacationStatusCard({super.key, required this.vacationRange, required this.status, required this.type});

  @override
  Widget build(BuildContext context) {

    final textJt12bold400White = Theme.of(context).textTheme.textJt12bold400White;
    final titleJt24Bold500Secondary = Theme.of(context).textTheme.titleJt24Bold500Secondary;

    final textOsw11boldPrimary = Theme.of(context).textTheme.textOsw11boldPrimary;
    final subtitleOsw16Bold500Secondary = Theme.of(context).textTheme.subtitleOsw16Bold500Secondary;

    final fontSizedGrow = getResponsiveScaleFactor(context);
    
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xfffaebd7),
            
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),

            )
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(vacationRange, style: subtitleOsw16Bold500Secondary.copyWith(fontSize: 16*fontSizedGrow),),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5 ),
                    decoration: BoxDecoration(
                      color: AppTheme.secondary,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Text(status,style: textJt12bold400White.copyWith(fontSize: 12*fontSizedGrow),)
                  ),

                ],
              ),
              const SizedBox(height: 5,),
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text('3 Días tomados de vacaciones de 12 dias dispinibles', style: textOsw11boldPrimary.copyWith(fontSize: 11*fontSizedGrow),)
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),

          child: Text(type, style: titleJt24Bold500Secondary.copyWith(fontSize: 24*fontSizedGrow),),
        )
      ],
    );
  }
}
