import 'package:flutter/material.dart';
import 'package:time_gate/themes/custom_styles.dart';
import 'package:time_gate/utils/calendar_data.dart';
import 'package:time_gate/utils/responsive_utils.dart';

class MonthlyRegistrationCard extends StatelessWidget {
  final double asistencia;
  final double vacaciones;
  final double ausencias;
  final double ausenciasPermitidas;
  final double totalVacaciones;
  final double asistenciasMensuales;

  const MonthlyRegistrationCard({
    super.key, required this.asistencia, 
    required this.vacaciones, 
    required this.ausencias, 
    required this.ausenciasPermitidas, 
    required this.totalVacaciones, 
    required this.asistenciasMensuales,
  });

  @override
  Widget build(BuildContext context) {

    final titleOsw20Bold500Secondary = Theme.of(context).textTheme.titleOsw20Bold500Secondary;
    
    final fontSizedGrow = getResponsiveScaleFactor(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      decoration: BoxDecoration(
        boxShadow: const[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 4),
    
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
    
        children: [
          Text('Registro Mensual', style: titleOsw20Bold500Secondary.copyWith(fontSize: 20*fontSizedGrow),),
          const SizedBox(height: 10,),
          Stack(
            alignment: AlignmentGeometry.center,
            children: [
               SizedBox(
                  width: 40*fontSizedGrow,
                  height: 40*fontSizedGrow,
                  child: CircularProgressIndicator(
                    value: (1.0 - (ausencias / ausenciasPermitidas)),                    
                    strokeWidth: 4,                   
                    backgroundColor: const Color.fromARGB(255, 187, 51, 41), 
                    valueColor: AlwaysStoppedAnimation<Color>(const Color.fromARGB(255, 255, 193, 193)),
                  ),
              ),
              SizedBox(
                  width: 70*fontSizedGrow,
                  height: 70*fontSizedGrow,
                  child: CircularProgressIndicator(
                    value: (1.0 - (asistencia/asistenciasMensuales)),                    
                    strokeWidth: 4,                   
                    backgroundColor: const Color.fromARGB(255, 255, 193, 193), 
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                  ),
                ),
               SizedBox(
                  width: 105*fontSizedGrow,
                  height: 105*fontSizedGrow,
                  child: CircularProgressIndicator(
                    value: (1.0 - (asistencia / asistenciasMensuales)),                    
                    strokeWidth: 4,                   
                    backgroundColor: const Color.fromARGB(255, 54, 125, 56), 
                    valueColor: AlwaysStoppedAnimation<Color>(const Color.fromARGB(255, 255, 193, 193)),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10,),
          Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TotalStatus(cant: asistencia.toInt(), type: 'Asistencia', color: Color(0xFF7e9758),),
              TotalStatus(cant: vacaciones.toInt(), type: 'Vacaciones', color: kColorVacaciones,),
              TotalStatus(cant: ausencias.toInt(), type: 'Ausencia', color: kColorFalta,),
            ],
          )
        ],
      ),
    );
  }
}

class TotalStatus extends StatelessWidget {
  final int cant;
  final String type;
  final Color color;
  const TotalStatus({
    super.key, required this.cant, required this.type, required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final textJt12bold400Secondary = Theme.of(context).textTheme.textJt12bold400Secondary;
    final textJt13bold400Secondary = Theme.of(context).textTheme.textJt13bold400Secondary;

    final fontSizedGrow = getResponsiveScaleFactor(context);
    return Container(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
      
          Container(
            width: 15*fontSizedGrow,
            height: 15*fontSizedGrow,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: BoxBorder.all(
                color: color,
                width: 2,
      
              )
            ),
          ),
          const SizedBox(width: 5,),
          Text('$cant', style: textJt12bold400Secondary.copyWith(color: color,fontSize: 12*fontSizedGrow),),
          const SizedBox(width: 5,),
          Text(type,style: textJt13bold400Secondary.copyWith(fontSize: 13*fontSizedGrow))
        ],
      ),
    );
  }
}