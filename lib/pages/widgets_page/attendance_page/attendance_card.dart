import 'package:flutter/material.dart';
import 'package:time_gate/themes/custom_styles.dart';
import 'package:time_gate/utils/responsive_utils.dart';

class AttendanceCard extends StatelessWidget {

  final Color color;
  final String type;
  final double maxProgress;
  final double currentProgress; 
  
  const AttendanceCard({
    super.key, required this.color, required this.type, required this.maxProgress, required this.currentProgress,
  });
  
  @override
  Widget build(BuildContext context) {
    final textOsw14bold400Na = Theme.of(context).textTheme.textOsw14bold400Na;
    final textOsw12bold400Secondary = Theme.of(context).textTheme.textOsw12bold400Secondary;
    final textOsw11bold400Secondary = Theme.of(context).textTheme.textOsw11bold400Secondary;

    final fontSizedGrow = getResponsiveScaleFactor(context);
   
    double progressRatio = currentProgress / maxProgress;

    const double circleSize = 50.0;
    const double borderWidth = 3.0; 

    return Container(
      padding: const EdgeInsets.all(10),
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
      child: Row(
        children: [
         
          SizedBox(
            width: circleSize*fontSizedGrow,
            height: circleSize*fontSizedGrow,
            child: Stack(
              alignment: Alignment.center,
              children: [
                
                SizedBox(
                  width: circleSize*fontSizedGrow,
                  height: circleSize*fontSizedGrow,
                  child: CircularProgressIndicator(
                    value: progressRatio,                    
                    strokeWidth: borderWidth,                   
                    backgroundColor: Colors.grey[300], 
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
                
                Column(
                  mainAxisSize: MainAxisSize.min, 
                  children: [
                    Text(
                      'Quedan', 
                      style: textOsw11bold400Secondary.copyWith(fontSize: 11*fontSizedGrow)
                    ),
                    Text(
                      '${currentProgress.toInt()}', 
                      style: textOsw12bold400Secondary.copyWith(fontSize: 12*fontSizedGrow)
                    )
                  ],
                ),
              ],
            ),
          ),
       
    
          const SizedBox(width: 10), 
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(type, style: textOsw14bold400Na.copyWith(color: color, fontSize: 14*fontSizedGrow)),
              Text('2 de 3 Disponibles', style: textOsw11bold400Secondary.copyWith(fontSize: 11*fontSizedGrow),)
            ],
          )
        ],
      ),
    );
  }
}