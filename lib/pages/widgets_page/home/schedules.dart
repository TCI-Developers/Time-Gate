import 'package:flutter/material.dart';
import 'package:time_gate/themes/app_theme.dart';
import 'package:time_gate/themes/custom_styles.dart';
import 'package:time_gate/utils/responsive_utils.dart';

class Schedules extends StatelessWidget {

  final String checkin;
  final String checkout;
  final String pause;
  
  const Schedules({
    super.key, required this.checkin, required this.checkout, required this.pause,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: AppTheme.secondary, 
      ),
      padding: const EdgeInsets.all(10),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _CheckTime(title: 'Chek In',text: checkin, border: false,),
            _CheckTime(title: 'Check Out',text: checkout, border: true,),
            _CheckTime(title: 'Pausa',text: pause, border: false,),
          ],
        ),
      )

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
    final subtitleOsw16Bold500Primary = Theme.of(context).textTheme.subtitleOsw16Bold500Primary;
    final textJt16bold400White = Theme.of(context).textTheme.textJt16bold400White;

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
              style: subtitleOsw16Bold500Primary.copyWith(
                fontSize: 18*fontSizedGrow
              ),
            ),
            Text(
              text,
              style: textJt16bold400White.copyWith(
                fontSize: 18*fontSizedGrow
              ),
            
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
} 