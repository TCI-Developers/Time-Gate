import 'package:flutter/material.dart';
import 'package:time_gate/themes/app_theme.dart';
import 'package:time_gate/themes/custom_styles.dart';
import 'package:time_gate/utils/responsive_utils.dart';

class DayOfWeekButton extends StatelessWidget {

  final String day;
  final String letterDay;
  final Color? indicatorColor;

  const DayOfWeekButton({super.key, required this.day, required this.letterDay, this.indicatorColor});


  @override
  Widget build(BuildContext context) {
   
    final textJt16bold400Secondary = Theme.of(context).textTheme.textJt16bold400Secondary;
    final fontSizedGrow = getResponsiveScaleFactor(context);

    return SizedBox(
      child:Column(
        children: [
          Text(letterDay, style: textJt16bold400Secondary.copyWith(
            fontSize: 16*fontSizedGrow
          ),),
          Container(
            
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 3),
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(50)
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 3,
                        offset: Offset(0, 2),
                      ),
                    ],
                    
                  ),
                  child: Text(day,style: textJt16bold400Secondary.copyWith(
                      fontSize: 16*fontSizedGrow
                  ),),
                ),
                const SizedBox(height: 5,),
                Container(
                  height: 10,
                  width: 10,
                      
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: indicatorColor ?? AppTheme.white,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
} 