import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:time_gate/pages/widgets_page/widgets_page.dart';
import 'package:time_gate/providers/attendance_provider.dart';
import 'package:time_gate/themes/app_theme.dart';
import 'package:time_gate/themes/custom_styles.dart';
import 'package:time_gate/utils/responsive_utils.dart';
import 'package:time_gate/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

   @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AttendanceProvider>().loadAttendance();
    });
  }
  @override
  Widget build(BuildContext context) {
    final attendance = context.watch<AttendanceProvider>();

    final double maxContainerWidth = getMaxContentWidth(context);
    final titleOsw30Bold30Secondary = Theme.of(context).textTheme.titleOsw30Bold30Secondary;
    final textJt16bold400Secondary = Theme.of(context).textTheme.textJt16bold400Secondary;
    final fontSizedGrow = getResponsiveScaleFactor(context);

    DateTime fechaActual = DateTime.now();
    String mesNombre = DateFormat('MMMM', 'es_Es').format(fechaActual).toUpperCase();
    String anioFormateado = DateFormat('yyyy').format(fechaActual);

    if (attendance.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (attendance.errorMessage != null) {
      return Center(child: Text(attendance.errorMessage!));
    }

    if (attendance.user == null) {
      return const SizedBox(); 
    }

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
                  PersonalInfo(
                    image: attendance.user!.profilePhotoPath,
                    name: attendance.user!.name,
                    jobTitle: attendance.user!.puesto,
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
                          child: Text('$mesNombre $anioFormateado', style: textJt16bold400Secondary.copyWith(
                          fontSize: 16 * fontSizedGrow,
                        ),),
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: attendance.days.map((day) {
                            return DayOfWeekButton(
                              letterDay: day.day,
                              day: day.date.split('-').last,
                              indicatorColor: 
                                (day.type ?? "").toLowerCase() =="asistencia" ? AppTheme.green
                                : (day.type ?? "").toLowerCase() =="ausencia" ? AppTheme.red
                                : (day.type ?? "").toLowerCase() =="vacaciones" ? Colors.amberAccent
                                : Colors.transparent
                                
                            );
                          }).toList(),
                        )

                      ],
                    ),
                  ),
                  ...attendance.days.map((day) {
                    return DayOfWeekCard(
                      day: day.date.split('-').last,
                      letterDay: day.day,
                      status: (day.type ?? "No status"),
                      checkIn: day.checkIn ?? '--',
                      checkOut: day.checkOut ?? '--',
                      pausa: day.totalPauseHuman,
                    );
                  }),

              
                ],
              )
            ),
          ),
        ),
    );
 
  }
}

