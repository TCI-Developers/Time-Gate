import 'package:flutter/material.dart';
import 'package:time_gate/themes/app_theme.dart';
import 'package:intl/intl.dart';
import 'package:time_gate/themes/custom_styles.dart';
import 'package:time_gate/utils/responsive_utils.dart';

class ActionButton extends StatelessWidget {

  final bool outlinedButton;
  final String title;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateFormat? dateFormat;
  final TimeOfDay? selectedTime;
  final VoidCallback? onTap;
  
  const ActionButton({
    super.key, required this.outlinedButton, required this.title, this.startDate, this.endDate,  this.dateFormat, this.selectedTime, this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    final textJt16bold700Secondary = Theme.of(context).textTheme.textJt16bold700Secondary;
    final fontSizedGrow = getResponsiveScaleFactor(context);
    return GestureDetector(
      // onTap: (){
      //   if(!outlinedButton){
      //     if (startDate != null && endDate != null) {
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         SnackBar(
      //           content: Text(
      //             'Solicitud de vacaciones del ${dateFormat!.format(startDate!)} al ${dateFormat!.format(endDate!)}',
      //           ),
      //         ),
      //       );
      //     }else if(startDate != null && selectedTime != null){
      //       ScaffoldMessenger.of(context).showSnackBar(
      //           SnackBar(
      //             content: Text(
      //               'Solicitud de Permisos ${dateFormat!.format(startDate!)} hora: ${selectedTime!.format(context)}',
      //             ),
      //           ),
      //         );
          
      //     }
      //   }else{
      //     Navigator.of(context).pop();
      //   }

      // },
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: outlinedButton ? null : AppTheme.primary,
          borderRadius: BorderRadius.circular(10),
          border: outlinedButton ? Border.all(color: AppTheme.primary) :null
        ),
        child: Text(title, style: textJt16bold700Secondary.copyWith(
            color: outlinedButton ? AppTheme.primary : Colors.white,
            fontSize: 16*fontSizedGrow
            // fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}