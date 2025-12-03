import 'package:flutter/material.dart';
import 'package:time_gate/pages/widgets_page/attendance_page/attendance_workpermits_subpage.dart';
import 'package:time_gate/pages/widgets_page/widgets_page.dart';
import 'package:time_gate/themes/custom_styles.dart';
import 'package:time_gate/utils/calendar_data.dart';
import 'package:time_gate/utils/responsive_utils.dart';
import 'package:time_gate/widgets/widgets.dart';

class AttendancePage extends StatefulWidget {

  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final List<DateTime> faltasAMostrar = [
    DateTime(2025, 11, 15), 
    DateTime(2025, 11, 22)
  ];

  final List<DateTime> retardosAMostrar = [
    DateTime(2025, 11, 16), 
    DateTime(2025, 11, 23)
  ];

  final List<DateTime> asistenciasAMostrar = [
    DateTime(2025, 11, 17), 
    DateTime(2025, 11, 24)
  ];

  final DateTime? inicioVacaciones = DateTime(2025, 11, 1);

  final DateTime? finVacaciones = DateTime(2025, 11, 10);
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {

    final double maxContainerWidth = getMaxContentWidth(context);
    
    final  titleOsw30Bold500Secondary = Theme.of(context).textTheme.titleOsw30Bold500Secondary;
    final fontSizedGrow = getResponsiveScaleFactor(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 60),
      child: SafeArea(
        child: Center(
          child: Container(
            width: maxContainerWidth,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text('Asistencia', style: titleOsw30Bold500Secondary.copyWith(fontSize: 30*fontSizedGrow),),
                const SizedBox(height: 20,),
                ReusableCalendar(
                  faltas: faltasAMostrar,
                  retardos: retardosAMostrar,
                  asistencias: asistenciasAMostrar,
                  rangeStart: inicioVacaciones,
                  rangeEnd: finVacaciones,
                  initialFocusedDay: DateTime(2025, 10, 12),
                ),
                const SizedBox(height: 20,),
                Wrap(  
                  alignment: WrapAlignment.spaceBetween, 
                  spacing: 4.0, 
                  runSpacing: 8.0,
                
                  children: [
                    GestureDetector(
                      onTap: () => {
                        setState(() {
                          tabIndex = 0;
                        })
                      },
                      child: AttendanceTag(text: 'Asistencias', color: Color(0xFF7e9758),index: 0, currentIndex: tabIndex,)
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          tabIndex =1;
                        });
                      },
                      child: AttendanceTag(text: 'Vacaciones', color: kColorVacaciones,index: 1, currentIndex: tabIndex,)
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          tabIndex =2;
                        });
                      },
                      child: AttendanceTag(text: 'Permisos', color: kColorSeleccionado,index: 2, currentIndex: tabIndex,)
                    ),
                    AttendanceTag(text: 'Ausencias', color: kColorFalta,index: 3,currentIndex: tabIndex),
                  ],
                ),
                const SizedBox(height: 20,),
          
                if(tabIndex == 0)
                  AttendanceAttendanceSubage()
                else if(tabIndex ==1)
                   AttendanceVacationSubage()
                else
                  AttendanceWorkpermitsSubpage()
              ],
            ),
          ),
        ),
      ),
    );
  }
}




