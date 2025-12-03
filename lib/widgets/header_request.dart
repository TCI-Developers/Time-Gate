import 'package:flutter/material.dart';
import 'package:time_gate/themes/app_theme.dart';
import 'package:time_gate/themes/custom_styles.dart';
import 'package:time_gate/utils/responsive_utils.dart';

class HeaderRequest extends StatelessWidget {

  final String title;
  const HeaderRequest({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final titleOsw28Bold500Secondary = Theme.of(context).textTheme.titleOsw28Bold500Secondary;

    final fontSizedGrow = getResponsiveScaleFactor(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              alignment: AlignmentGeometry.center,
              children: [
                Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: IconButton(
                    alignment: Alignment.center,
                    icon: const Icon(Icons.arrow_back_ios_outlined), 
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(AppTheme.primary), 
                      foregroundColor: WidgetStatePropertyAll(Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                SizedBox(width: title ==  'Solicitud \n de Permiso' ? 40 : 20,),
                Align(
                  alignment: Alignment.center,
                  child: Text(title, style: titleOsw28Bold500Secondary.copyWith(fontSize: 28*fontSizedGrow),
                  textAlign: TextAlign.center,
                              ),
                )
            
              ],
            ),
          ),
          
          
        ],
      ),
    );
  }
}

