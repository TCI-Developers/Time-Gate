import 'package:flutter/material.dart';
import 'package:time_gate/themes/app_theme.dart';
import 'package:time_gate/themes/custom_styles.dart';
import 'package:time_gate/utils/responsive_utils.dart';

class AttendanceVacationCard extends StatelessWidget {

  final String totalDays;
  final String usedDays;
  final String remainingDays;
  final String buttonTitle;

  
  const AttendanceVacationCard({
    super.key, required this.totalDays, required this.usedDays, required this.remainingDays,  required this.buttonTitle,
  });

  @override
  Widget build(BuildContext context) {
    final titleJt18Bold700White = Theme.of(context).textTheme.titleJt18Bold700White;
    final fontSizedGrow = getResponsiveScaleFactor(context);
    

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DaysSection(days: totalDays, type: 'Total',),
            DaysSection(days: usedDays, type: 'Usados',),
            DaysSection(days: remainingDays, type: 'Restantes'),
          ],
        ),
        const SizedBox(height: 20,),
        SizedBox(
          width: double.infinity, 
          child: TextButton(
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(AppTheme.primary),
                      foregroundColor: WidgetStatePropertyAll(Colors.white),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)), 
                        ),
                      ),
                      padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 5.0)),
                    ),
                    onPressed: (){
                      if(buttonTitle == "Solicitar Permiso"){
                        Navigator.pushNamed(context, 'permit application');
                      }else{
                        Navigator.pushNamed(context, 'vacation request');
                      }
                    }, 
                    child:  Text(buttonTitle, style: titleJt18Bold700White.copyWith(fontSize: 18*fontSizedGrow),),
                  ),
        )
      ],
    );
  }
}

class DaysSection extends StatelessWidget {

  const DaysSection({
    super.key,
    required this.days, required this.type,
  });

  final String days;
  final String type;

  @override
  Widget build(BuildContext context) {
    final textJt16bold400Secondary = Theme.of(context).textTheme.textJt16bold400Secondary;
    final textOsw14bold500Primary = Theme.of(context).textTheme.textOsw14bold500Primary;

    final fontSizedGrow = getResponsiveScaleFactor(context);
    return Column(
      children: [
        Text(days, style: 
          textJt16bold400Secondary.copyWith(
            fontSize: 18*fontSizedGrow,
            color: AppTheme.secondary
          ),
        ),
        Text(type, style: 
          textOsw14bold500Primary.copyWith(
            fontSize: 14*fontSizedGrow
          )
        ,),
      ],
    );
  }
}