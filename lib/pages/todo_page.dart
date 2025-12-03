import 'package:flutter/material.dart';
import 'package:time_gate/utils/responsive_utils.dart';

class TodoPage extends StatelessWidget {
  
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

  
  TodoPage({super.key});

  @override
  Widget build(BuildContext context) {

    final double maxContainerWidth = getMaxContentWidth
    (context);

    return SafeArea(
      child: Container(
        width: maxContainerWidth,
        padding: EdgeInsets.all(20),
      
        child: Column(
          children: [
            Text('')
          ],
        ),
      ),
    );
  }
}

