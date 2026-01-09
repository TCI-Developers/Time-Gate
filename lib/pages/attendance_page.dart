import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_gate/pages/widgets_page/attendance_page/attendance_workpermits_subpage.dart';
import 'package:time_gate/pages/widgets_page/widgets_page.dart';
import 'package:time_gate/providers/attendance_provider.dart';
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
    // 1. Disparamos la carga inicial al entrar a la página
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final tabIndexPrincipal = context.read<TabbarProvider>().selectedMEnuOption;
      final attendanceProv = context.read<AttendanceProvider>();

      // Verificamos condiciones para la carga inicial
      if (tabIndexPrincipal == 1 && 
          attendanceProv.entries.isEmpty && 
          !attendanceProv.isLoading) {
        _fetchAttendance();
      }
    });
  }

  void _fetchAttendance() {
    if (!mounted) return;
    // 1. Determinamos el tipo según el tab seleccionado
    String type = 'asistencias';
    if (tabIndex == 1) type = 'vacaciones';
    if (tabIndex == 2) type = 'permisos';
    if (tabIndex == 3) type = 'ausencias';

    // 2. Llamamos al provider pasando los 3 datos: tipo, mes y año
    context.read<AttendanceProvider>().loadAttendance(
      type: type,
      month: _currentFocusedDate.month,
      year: _currentFocusedDate.year,
    );
  }

  List<DateTime> _parseDates(List<String> dates) {
    return dates.map((d) => DateTime.parse(d)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final tabIndexPrincipal = context.watch<TabbarProvider>().selectedMEnuOption;
    final attendanceProv = context.watch<AttendanceProvider>();
    final stats = attendanceProv.stats;
    
    final double maxContainerWidth = getMaxContentWidth(context);
    final titleOsw30Bold500Secondary = Theme.of(context).textTheme.titleOsw30Bold500Secondary;
    final fontSizedGrow = getResponsiveScaleFactor(context);

    // 2. Lógica de disparo (Lazy Loading)
    if (tabIndexPrincipal == 1 && 
        attendanceProv.entries.isEmpty && 
        !attendanceProv.isLoading && 
        attendanceProv.errorMessage == null) {
      
      Future.microtask(() => _fetchAttendance());
    }

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
                      Text('Asistencia', style: titleOsw30Bold500Secondary.copyWith(fontSize: 30*fontSizedGrow),),
                      const SizedBox(height: 20,),
                     
                      ReusableCalendar(
                        
                        key: ValueKey('cal-${_currentFocusedDate.month}-${attendanceProv.stats == null}'),
                        faltas: _parseDates(stats?.fechaAusencias ?? []),
                        retardos: _parseDates(stats?.fechaRetardo ?? []),
                        asistencias: [], 
                        rangeStart: stats?.fechaVacaciones.isNotEmpty == true 
                            ? DateTime.parse(stats!.fechaVacaciones.first) : null,
                        rangeEnd: stats?.fechaVacaciones.isNotEmpty == true 
                            ? DateTime.parse(stats!.fechaVacaciones.last) : null,
                        initialFocusedDay: _currentFocusedDate, // ⬅️ USAR LA VARIABLE
                        
                        // 🆕 CONECTAR EL CAMBIO DE MES
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
                                tabIndex = 0; // Primero actualizamos el índice
                              });
                              _fetchAttendance(); // Luego pedimos los datos con el índice nuevo
                            },
                            child: AttendanceTag(text: 'Asistencias', color: Color(0xFF7e9758),index: 0, currentIndex: tabIndex,)
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                tabIndex = 1; // Primero actualizamos el índice
                              });
                              _fetchAttendance(); // Luego pedimos los datos con el índice nuevo
                            },
                            child: AttendanceTag(text: 'Vacaciones', color: kColorVacaciones,index: 1, currentIndex: tabIndex,)
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                tabIndex = 2; // Primero actualizamos el índice
                              });
                              _fetchAttendance(); // Luego pedimos los datos con el índice nuevo
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
                         AttendanceVacationSubage()
                      else
                        AttendanceWorkpermitsSubpage()
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




