import 'package:flutter/material.dart';
import 'package:time_gate/pages/widgets_page/widgets_page.dart';
import 'package:time_gate/utils/calendar_data.dart';

class AttendanceAttendanceSubage extends StatelessWidget {
  const AttendanceAttendanceSubage({super.key});

  @override
  Widget build(BuildContext context) {
   
    return Column(
      children: [
        Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    AttendanceCard( color: Colors.red, type: 'Retardos', maxProgress: 3, currentProgress: 1,),
                    const SizedBox(height: 10,),
                    AttendanceCard(color: kColorSeleccionado, type: 'Permisos', maxProgress: 3, currentProgress: 2,),
                    const SizedBox(height: 10,),
                    AttendanceCard(color: Colors.orange, type: 'Vacaciones', maxProgress: 12, currentProgress: 6,),
                        
                  ],
                ),
              ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: Column(
                      children: [
                        MonthlyRegistrationCard()
                      ],
                    ),
                  )
                
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              AttendanceCardTwo(color: Colors.red, type: 'Asistencias', maxProgress: 31, currentProgress: 20,text: 'de 160 hrs de trabajo ordinario',),
              const SizedBox(width: 10,),
              AttendanceCardTwo(color: Colors.red, type: 'Ausencias', maxProgress: 31, currentProgress: 20, text: 'horas de retraso',),    
            ],
          ),
          const SizedBox(height: 20,),
          AttendanceResumeCard(checkIn: '63 h 00 m', checkOut: '20 h',pausa: '0 h',),
          const SizedBox(height: 20,),
          AttendanceCardDay(
            checkin: '8:00 am',
            checkout: '5:00 pm',
            pause: '2:00 am - 3:00 am - 9:00 pm',
            hoursworked: '8:00 am',
          )
      ],
    );
  }
}