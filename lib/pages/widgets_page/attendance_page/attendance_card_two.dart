import 'package:flutter/material.dart';
import 'package:time_gate/themes/custom_styles.dart';
import 'package:time_gate/utils/responsive_utils.dart';

class AttendanceCardTwo extends StatelessWidget {

  final Color color;
  final String type;
  final double maxProgress;
  final double currentProgress; 
  final String text;
  final String horas;
  
  const AttendanceCardTwo({
    super.key, required this.color, required this.type, required this.maxProgress, required this.currentProgress, required this.text, required this.horas,
  });
  
  @override
  Widget build(BuildContext context) {
    
    final titleJt18Bold500Secondary = Theme.of(context).textTheme.titleJt18Bold500Secondary;
    final subtitleOsw16Bold500Secondary = Theme.of(context).textTheme.subtitleOsw16Bold500Secondary;
    final textJt16bold400Secondary = Theme.of(context).textTheme.textJt16bold400Secondary;
    final textJt13bold400Secondary = Theme.of(context).textTheme.textJt13bold400Secondary;
    final textJt11bold400Secondary = Theme.of(context).textTheme.textJt11bold400Secondary;
    final textJt10boldNormalSecondary = Theme.of(context).textTheme.textJt10boldNormalSecondary;

    final fontSizedGrow = getResponsiveScaleFactor(context);

    double progressRatio = currentProgress / maxProgress;

     double circleSize = 73.0*fontSizedGrow;
     double borderWidth = 3.0*fontSizedGrow; 
     

    return Expanded(
      child: Container(
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
            Column(
              children: [
                Text(type, style: subtitleOsw16Bold500Secondary.copyWith(color: color,fontSize: 16*fontSizedGrow),),
                const SizedBox(height: 5,),
                SizedBox(
                  width: circleSize,
                  height: circleSize,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      
                      SizedBox(
                        width: circleSize,
                        height: circleSize,
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
                    
                          Text.rich(
                            textAlign: TextAlign.center,
                            style: TextStyle(height: 1, ),
                            TextSpan(
                                children: <TextSpan>[
                                    TextSpan(
                                        text: '${currentProgress.toInt()}',
                                        style: titleJt18Bold500Secondary.copyWith(
                                            fontSize: 18*fontSizedGrow,
                                            color: color
                                        ),
                                    ),
                                    TextSpan(
                                        text: ' Días', 
                                        style: textJt10boldNormalSecondary.copyWith(
                                          fontSize: 10*fontSizedGrow
                                        ),
                                    ),
                                ],
                            ),
                          ),
                          Text('De ${maxProgress.toInt()} días', style: textJt10boldNormalSecondary.copyWith(
                            fontSize: 10*fontSizedGrow
                          ),)
                          
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
         
            const SizedBox(width: 10), 
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Horas', 
                    style: textJt16bold400Secondary.copyWith(color: color, fontWeight: FontWeight.w900, fontSize: 16*fontSizedGrow), softWrap: true, maxLines: null,),
                  Text('$horas hrs', 
                    style: textJt13bold400Secondary, softWrap: true, maxLines: null,),
                  Text(text, 
                    style: textJt11bold400Secondary.copyWith(height: .9, fontSize: 13*fontSizedGrow), softWrap: true, maxLines: null,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}