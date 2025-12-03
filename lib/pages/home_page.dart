import 'package:flutter/material.dart';
import 'package:time_gate/pages/widgets_page/widgets_page.dart';
import 'package:time_gate/themes/app_theme.dart';
import 'package:time_gate/themes/custom_styles.dart';
import 'package:time_gate/utils/responsive_utils.dart';
import 'package:time_gate/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    final double maxContainerWidth = getMaxContentWidth(context);
    final titleOsw30Bold30Secondary = Theme.of(context).textTheme.titleOsw30Bold30Secondary;
    final textJt16bold400Secondary = Theme.of(context).textTheme.textJt16bold400Secondary;
    final fontSizedGrow = getResponsiveScaleFactor(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 60),
      child: SafeArea(
          child: Center(
            child: Container(
              width: maxContainerWidth,
              padding: const EdgeInsets.all(20),
              child: Column(
                spacing: 10,
                children: [
                  const PersonalInfo(
                    image: 'https://upload.wikimedia.org/wikipedia/commons/7/7b/Stan_Lee_by_Gage_Skidmore_3.jpg',
                    name: 'Alan Alexis Medrano Gomez',
                    jobTitle: 'Puesto',
                  ),
                  Align(
                    alignment: AlignmentGeometry.centerLeft,
                    child: Text('Bienvenido',
                        style: titleOsw30Bold30Secondary.copyWith(
                          fontSize: 30 * fontSizedGrow,
                        )
                    ),
                  ),
                  Schedules(checkin: '8:00 am', checkout: '8:00 am', pause: '8:00 am / 3:00 pm',),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: CheckButton(iconStart: Icons.watch_later_outlined,text: 'Check In',)),
                      const SizedBox(width: 10,),
                      Expanded(child: CheckButton(iconStart: Icons.logout,text: 'Check Out',)), 
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start, 
                    children: [
                      Flexible(
                        flex: 1,
                        child: PauseSection(),
                      ),
                      const SizedBox(width: 10,),
                      Flexible(
                        flex: 1,
                        child: CheckButton(
                          iconStart: Icons.play_circle_outline,
                          text: 'Reanudar',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsetsGeometry.only(left: 8),
                          child: Text(
                            'Resumen de la semana',
                            style: titleOsw30Bold30Secondary.copyWith(
                          fontSize: 30 * fontSizedGrow,
                        ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsGeometry.only(left:8),
                          child: Text('JULIO 2025', style: textJt16bold400Secondary.copyWith(
                          fontSize: 16 * fontSizedGrow,
                        ),),
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DayOfWeekButton(letterDay: 'LUN',day: '14', indicatorColor: AppTheme.primary,),
                            DayOfWeekButton(letterDay: 'MAR',day: '15', indicatorColor: AppTheme.red,),
                            DayOfWeekButton(letterDay: 'MIE',day: '16', indicatorColor: AppTheme.green,),
                            DayOfWeekButton(letterDay: 'JUE',day: '17', indicatorColor: AppTheme.secondary,),
                            DayOfWeekButton(letterDay: 'VIE',day: '18', indicatorColor: AppTheme.black,),
                            DayOfWeekButton(letterDay: 'SAB',day: '19',),
                            DayOfWeekButton(letterDay: 'DOM',day: '20',),
                           
                          ],
                        )
                      ],
                    ),
                  ),
                  DayOfWeekCard(day: '13',letterDay: 'DOM', status: 'Asistencia', checkIn: '0:00 am', checkOut: '0:00 pm',pausa: '0:00 am',),
                  DayOfWeekCard(day: '14',letterDay: 'LUN', status: 'Asistencia', checkIn: '0:00 am', checkOut: '0:00 pm',pausa: '0:00 am',),
                  DayOfWeekCard(day: '15',letterDay: 'MAR', status: 'Asistencia', checkIn: '0:00 am', checkOut: '0:00 pm',pausa: '0:00 am',),
                  DayOfWeekCard(day: '16',letterDay: 'MIE', status: 'Vacaciones', checkIn: '0:00 am', checkOut: '0:00 pm',pausa: '0:00 am',),
                  DayOfWeekCard(day: '17',letterDay: 'JUE', status: 'Asistencia', checkIn: '0:00 am', checkOut: '0:00 pm',pausa: '0:00 am',),
                  DayOfWeekCard(day: '18',letterDay: 'VIE', status: 'Asistencia', checkIn: '0:00 am', checkOut: '0:00 pm',pausa: '0:00 am',),
                  DayOfWeekCard(day: '19',letterDay: 'SAB', status: 'Ausencia', checkIn: '0:00 am', checkOut: '0:00 pm',pausa: '0:00 am',),
              
                ],
              )
            ),
          ),
        ),
    );
 
  }
}

