import 'package:flutter/material.dart';
import 'package:time_gate/themes/app_theme.dart';
import 'package:time_gate/themes/custom_styles.dart';
import 'package:time_gate/utils/responsive_utils.dart';

class DayOfWeekCard extends StatelessWidget {

  final String day;
  final String letterDay;
  final String status;
  final String checkIn;
  final String checkOut;
  final String pausa;

  const DayOfWeekCard({super.key, required this.day, required this.letterDay, required this.status, required this.checkIn, required this.checkOut, required this.pausa,});
  
  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: AppTheme.grey,
      ),
      child: Row(
        children: [
          _DayOfWeekButton(day: day, letterDay: letterDay, status: status,),
          _CheckTime(title: 'Check In', text: checkIn, border: false),
          _CheckTime(title: 'Check Out', text: checkOut, border: true),
          _CheckTime(title: 'Pausa', text: pausa, border: false),
        ],
      ),
    );
  }
}


class _DayOfWeekButton extends StatelessWidget {

  final String day;
  final String letterDay;
  final String status;

  const _DayOfWeekButton({required this.day, required this.letterDay, required this.status});

  @override
  Widget build(BuildContext context) {
    
    final textJt16bold400Secondary = Theme.of(context).textTheme.textJt16bold400Secondary;
    final fontSizedGrow = getResponsiveScaleFactor(context);
    
    return Expanded(
      child:Column(
        children: [
          Text(letterDay, style: textJt16bold400Secondary.copyWith(
            fontSize: 16*fontSizedGrow
          ),),
          Container(

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
       
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  
                  decoration: BoxDecoration(
                    
                    shape: BoxShape.circle,
                    color: AppTheme.white,     
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    
                  ),
                  child: Text(day,style: textJt16bold400Secondary.copyWith(
                    fontSize: 16*fontSizedGrow
                  ),),
                ),
                const SizedBox(height: 5,),
                Container(
                  
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: status == 'asistencia'
                        ? Colors.lightGreen
                    : status == 'asistencia'
                        ? Colors.lightGreen
                    : status == 'vacaciones' 
                        ? Colors.yellow
                    : status == 'ausencia'
                        ? AppTheme.red
                    : status == 'retardo'    
                        ? const Color.fromARGB(255, 151, 42, 34)
                        : Colors.transparent
                    ,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Text(status, style: textJt16bold400Secondary.copyWith(fontSize: 12*fontSizedGrow),),
                )
              ],
            ),
          )
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
    final textOsw14bold500Primary = Theme.of(context).textTheme.textOsw14bold500Primary;
    final textJt16bold400Secondary = Theme.of(context).textTheme.textJt16bold400Secondary;
    final fontSizedGrow = getResponsiveScaleFactor(context);


    return Expanded(
      child: Container(
      decoration: border
            ? const BoxDecoration(
                border: Border.symmetric(
                  vertical: BorderSide(width: 2, color: AppTheme.white),
                ),
              )
            : null,
        child: Column(
          children: [
            Text(
              title,
              style: textOsw14bold500Primary.copyWith(fontSize: 14*fontSizedGrow),
            ),
            Text(
              text,
              style: textJt16bold400Secondary.copyWith(fontSize: 16*fontSizedGrow),
              softWrap: true,              
              textAlign: TextAlign.center, 
            ),
          ],
        ),
      ),
    );
  }
}