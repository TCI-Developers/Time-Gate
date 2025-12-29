import 'package:flutter/material.dart';
import 'package:time_gate/themes/app_theme.dart';
import 'package:time_gate/themes/custom_styles.dart';
import 'package:time_gate/utils/responsive_utils.dart';

class CheckButton extends StatelessWidget {
  final IconData iconStart;

  final Widget? iconEnd; 
  final String text;
  final VoidCallback? onTap;

  const CheckButton({
    super.key,
    required this.iconStart,
    this.iconEnd, 
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    final titleJt18Bold500Secondary = Theme.of(context).textTheme.titleJt18Bold500Secondary;
    final fontSizedGrow = getResponsiveScaleFactor(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.primary,
          borderRadius: BorderRadius.circular(20),
          
        ),
      
      
        height: 60*fontSizedGrow,
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            
            Icon(iconStart, color: Colors.white, size: 40*fontSizedGrow,),
            const SizedBox(width: 10,),
            Expanded(
              
              child: Text(
                text,
                style: titleJt18Bold500Secondary.copyWith(
                  fontSize: 18 *fontSizedGrow
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ),
      
            if (iconEnd != null) ...[
              iconEnd!
            ],
          ],
        ),
      ),
    );
  }
} 