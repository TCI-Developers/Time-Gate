import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_gate/core/models/attendance_stats.model.dart';
import 'package:time_gate/pages/widgets_page/attendance_page/attendance_workpermits_subpage.dart';
import 'package:time_gate/pages/widgets_page/widgets_page.dart';
import 'package:time_gate/providers/attendance_provider.dart';
import 'package:time_gate/providers/auth_provider.dart';
import 'package:time_gate/providers/tabbar_provider.dart';
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

  int tabIndex = 0;
  DateTime _currentFocusedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    
  }
  
  void _fetchAttendance() {
    final attendanceProv = context.read<AttendanceProvider>();
    if (!mounted || attendanceProv.isLoading) return;

    attendanceProv.entries = []; 

    String type = 'asistencia';
    if (tabIndex == 1) type = 'vacaciones';
    if (tabIndex == 2) type = 'permisos';

    attendanceProv.loadAttendance(
      type: type,
      month: _currentFocusedDate.month,
      year: _currentFocusedDate.year,
    );
  }
  
  List<DateTime> _parseDates(List<String> dates) {
    if(dates.isEmpty) return[];
    try {
      return dates.map((d) => DateTime.parse(d)).toList();
    } catch (e) {

      return [];
    }
  }

  final DateTime? inicioVacaciones = DateTime(2025, 11, 1);

  final DateTime? finVacaciones = DateTime(2025, 11, 10);
    
  
  @override
  Widget build(BuildContext context) {
    final attendanceProv = context.watch<AttendanceProvider>();
    final tabProvider = context.watch<TabbarProvider>();

    final authProv = context.watch<AuthProvider>();

    // if (tabProvider.selectedMEnuOption == 1 &&
    //   authProv.token != null &&
    //   attendanceProv.stats == null &&
    //   !attendanceProv.isLoading) {
    
    //   Future.microtask(() => _fetchAttendance());
    // }
    if (tabProvider.selectedMEnuOption == 1) {
      if (authProv.token != null && attendanceProv.stats == null && !attendanceProv.isLoading) {
        Future.microtask(() => _fetchAttendance());
      }
    }else {
      if (tabIndex != 0) {
        tabIndex = 0; 
        attendanceProv.clearSilent();
      }
    }

    final stats = attendanceProv.stats;

    final List<VacacionRange> vacacionesRangos = stats?.fechaVacaciones ?? [];

    final double maxContainerWidth = getMaxContentWidth(context);
    final titleOsw30Bold500Secondary = Theme.of(context).textTheme.titleOsw30Bold500Secondary;
    final fontSizedGrow = getResponsiveScaleFactor(context);

    final List<DateTime> asistenciasOriginales = _parseDates(stats?.fechaAsistencia ?? []);
    final List<DateTime> retardosList = _parseDates(stats?.fechaRetardo ?? []);
    final List<DateTime> asistenciasLimpias = asistenciasOriginales.where((asistencia) {
      return !retardosList.any((retardo) => 
        asistencia.year == retardo.year && 
        asistencia.month == retardo.month && 
        asistencia.day == retardo.day
      );
    }).toList();

    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () async => _fetchAttendance(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 60),
            physics: const AlwaysScrollableScrollPhysics(),
            child: SafeArea(
              child: Center(
                child: Container(
                  width: maxContainerWidth,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        tabIndex == 0 
                        ? 'Asistencia'
                        : tabIndex == 1
                        ? 'Vacaciones'
                        : 'Permisos', 
                        style: titleOsw30Bold500Secondary.copyWith(fontSize: 30*fontSizedGrow),
                      ),
                      const SizedBox(height: 20,),
                     
                      ReusableCalendar(
                        
                        key: ValueKey('cal-${_currentFocusedDate.month}-${attendanceProv.stats == null}'),
                        faltas: _parseDates(stats?.fechaAusencias ?? []),
                        retardos: retardosList,
                        asistencias:  asistenciasLimpias.isNotEmpty 
                          ? asistenciasLimpias 
                          : _parseDates(stats?.fechaPermisos ?? []), 
                        vacacionesRangos: vacacionesRangos,
                        rangeStart: inicioVacaciones,
                        rangeEnd: finVacaciones,
                        initialFocusedDay: _currentFocusedDate, 
                    
                        onPageChanged: (newDate) {
                          setState(() => _currentFocusedDate = newDate);
                          _fetchAttendance();
                        },
                      ),
                      const SizedBox(height: 20,),
                      Wrap(  
                        alignment: WrapAlignment.spaceBetween, 
                        spacing: 4.0, 
                        runSpacing: 8.0,
                      
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                tabIndex = 0;
                              });
                              _fetchAttendance();
                            },
                            child: AttendanceTag(text: 'Asistencias', color: Color(0xFF7e9758),index: 0, currentIndex: tabIndex,)
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                tabIndex = 1;
                              });
                              _fetchAttendance();
                            },
                            child: AttendanceTag(text: 'Vacaciones', color: kColorVacaciones,index: 1, currentIndex: tabIndex,)
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                tabIndex = 2;
                              });
                              _fetchAttendance();
                            },
                            child: AttendanceTag(text: 'Permisos', color: kColorSeleccionado,index: 2, currentIndex: tabIndex,)
                          ),
                          AttendanceTag(text: 'Ausencias', color: kColorFalta,index: 3,currentIndex: tabIndex),
                        ],
                      ),
                      const SizedBox(height: 20,),
                
                      if(tabIndex == 0)
                        AttendanceAttendanceSubage(data: attendanceProv.entries, stats: stats,)
                      else if(tabIndex ==1)
                         AttendanceVacationSubage(data: attendanceProv.entries, stats: stats,)
                      else if(tabIndex ==2)
                        AttendanceWorkpermitsSubpage(data: attendanceProv.entries, stats: stats,)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        if (attendanceProv.isLoading)
        Container(
          color: Colors.black45,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }
}
