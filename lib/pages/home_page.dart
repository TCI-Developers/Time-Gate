import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:time_gate/pages/widgets_page/widgets_page.dart';
import 'package:time_gate/providers/home_provider.dart';
import 'package:time_gate/providers/tabbar_provider.dart';
import 'package:time_gate/themes/app_theme.dart';
import 'package:time_gate/themes/custom_styles.dart';
import 'package:time_gate/utils/dialog_confirmation.dart';
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
      final tabbarProv = context.read<TabbarProvider>();
      final homeProv = context.read<HomeProvider>();

      // Solo cargamos si el índice es 0 y no hay datos cargados aún
      if (tabbarProv.selectedMEnuOption == 0 && homeProv.user == null) {
        homeProv.loadHome();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final tabbarProv = context.watch<TabbarProvider>();
    final attendance = context.watch<HomeProvider>();

    if (tabbarProv.selectedMEnuOption == 0 && 
      attendance.user == null && 
      !attendance.isLoading) {
      Future.microtask(() => attendance.loadHome());
    }

    final double maxContainerWidth = getMaxContentWidth(context);
    final titleOsw30Bold30Secondary = Theme.of(context).textTheme.titleOsw30Bold30Secondary;
    final textJt16bold400Secondary = Theme.of(context).textTheme.textJt16bold400Secondary;
    final fontSizedGrow = getResponsiveScaleFactor(context);

    DateTime fechaActual = DateTime.now();
    String mesNombre = DateFormat('MMMM', 'es_Es').format(fechaActual).toUpperCase();
    String anioFormateado = DateFormat('yyyy').format(fechaActual);

    if (attendance.isLoading && attendance.user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (attendance.user == null) {
    return const Scaffold(
      body: Center(child: Text("No se pudo cargar la información")),
    );
  }

    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () async => await attendance.loadHome(),
          child: SingleChildScrollView(
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
                        Schedules(checkin: attendance.user!.horaEntrada, checkout: attendance.user!.horaSalida, pause: '${attendance.user!.horaInicioComida}/ ${attendance.user!.horaFinComida}',),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CheckButton(
                                iconStart: Icons.watch_later_outlined,text: 'Check In',
                                onTap: ()async{
                                  dialogConfirm(
                                    context: context, 
                                    title: 'Check In',
                                    message: '¿Deseas hacer check in?',
                                    onConfirmed: ()async{
                                      final provider = context.read<HomeProvider>();
                                      final ok = await provider.checkIn();
          
                                      if (!context.mounted) return;
                                      showDialog(
                                        context: context, 
                                        builder: (BuildContext context)=>AlertDialog(
                                          title: Text(ok ? 'Éxito' : 'Error'),
                                          content: Text(
                                            ok ? provider.successMessage! : provider.errorMessage!,
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(context), 
                                              child: const Text('ok'),
                                            ),
                                            
                                          ],
                                        ),
                                      );
                                    }
                                  );
                                },),
                              
                            ),
                            const SizedBox(width: 10,),
          
                            Expanded(
                              child: CheckButton(
                                iconStart: Icons.logout,text: 'Check Out',
                                onTap: ()async{
                                  dialogConfirm(
                                    context: context, 
                                    title: 'Check Out',
                                    message: '¿Deseas hacer check out?',
                                    onConfirmed: ()async{
                                      final provider = context.read<HomeProvider>();
                                      final ok = await provider.checkOut();
                                      if (!context.mounted) return;
                                      showDialog(
                                        context: context, 
                                        builder: (BuildContext context)=>AlertDialog(
                                          title: Text(ok ? 'Éxito' : 'Error'),
                                          content: Text(
                                            ok ? provider.successMessage! : provider.errorMessage!,
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(context), 
                                              child: const Text('ok'),
                                            ),
                                            
                                          ],
                                        ),
                                      );
                                    }
                                  );
                                }),
                            ), 
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
                                onTap: ()async{
                                  dialogConfirm(
                                    context: context, 
                                    title: 'Reanudar',
                                    message: '¿Deseas reanudar tu jornada?',
                                    onConfirmed: ()async{
                                      final provider = context.read<HomeProvider>();
                                      final ok = await provider.restart();
          
                                      if (!context.mounted) return;
                                      showDialog(
                                        context: context, 
                                        builder: (BuildContext context)=>AlertDialog(
                                          title: Text(ok ? 'Éxito' : 'Error'),
                                          content: Text(
                                            ok ? provider.successMessage! : provider.errorMessage!,
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(context), 
                                              child: const Text('ok'),
                                            ),
                                            
                                          ],
                                        ),
                                      );
                                    }
                                  );
                                },
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
                                      : (day.type ?? "").toLowerCase() =="permiso" ? AppTheme.green
                                      : (day.type ?? "").toLowerCase() =="ausencia" ? const Color.fromARGB(255, 203, 63, 53)
                                      : (day.type ?? "").toLowerCase() =="vacaciones" ? Colors.amberAccent
                                      : (day.type ?? "").toLowerCase() =="retardo" ? AppTheme.red
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
          ),
        ),
        if (attendance.isLoading)
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

