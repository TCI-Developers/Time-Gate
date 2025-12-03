import 'package:flutter/material.dart';
import 'package:time_gate/themes/custom_styles.dart';
import 'package:time_gate/utils/responsive_utils.dart';

class AttendanceTag extends StatelessWidget {
  final String text;
  final Color color;
  final int? currentIndex;
  final int? index; 
 
  
  const AttendanceTag({
    super.key, required this.text, required this.color,  this.currentIndex, this.index,
  });

  @override
  Widget build(BuildContext context) {
    final textJt14bold400Na = Theme.of(context).textTheme.textJt14bold400Na;
    final fontSizedGrow = getResponsiveScaleFactor(context);
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color:index == currentIndex ? color : color.withAlpha(150) ,
      ),
      child: Text(text, style: textJt14bold400Na.copyWith(
        fontWeight: FontWeight.w900, 
        fontSize: 14*fontSizedGrow,
        color: index == currentIndex ? Colors.white : color,

        ),
      )
    );
  }
}