import 'package:flutter/material.dart';
import 'package:time_gate/themes/custom_styles.dart';
import 'package:time_gate/utils/responsive_utils.dart';
import 'package:time_gate/widgets/logout_button.dart';
import 'package:time_gate/widgets/widgets.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final titleOsw28Bold500Secondary = Theme.of(context).textTheme.titleOsw28Bold500Secondary;
    final titleOsw24Bold500Primary = Theme.of(context).textTheme.titleOsw24Bold500Primary;
    final titleJt20Bold500Grey = Theme.of(context).textTheme.titleJt20Bold500Grey;
    final fontSizedGrow = getResponsiveScaleFactor(context);

    final double maxContainerWidth = getMaxContentWidth(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 60),
      child: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            width: maxContainerWidth,
            child: Column(
              spacing: 10,
              children: [
                Text('Perfil', style: titleOsw28Bold500Secondary.copyWith(fontSize: 28*fontSizedGrow)),
                const SizedBox(height: 10,),
                CirclePhoto(maxRadius: 60, image: 'https://upload.wikimedia.org/wikipedia/commons/7/7b/Stan_Lee_by_Gage_Skidmore_3.jpg'),
                const SizedBox(height: 10,),
                Text('Alexis Medrano Gomez', style: titleOsw28Bold500Secondary.copyWith(fontSize: 28*fontSizedGrow),),
                Text('Puesto',style: titleJt20Bold500Grey.copyWith(fontSize: 20*fontSizedGrow),),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InfoColumn(title: 'Area',description: 'Comunicacion',),
                    InfoColumn(title: 'ID de Empleado',description: '53',),
                    InfoColumn(title: 'Antiguedad',description: '2 Años',),
                  ],
                ),
               const SizedBox(height: 10,),
               
               Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text('Información General', style: titleOsw24Bold500Primary,),
               ),
               
               PersonalInfo(title: 'Nombre Completo', info: 'Alan Alexis Medrano Gomez' ,),
               PersonalInfo(title: 'Dirección', info: 'Volcán  Pelee 468 interior 801, Lomas del Paraíso 3ra, C.P 44250; Guadalajara, Jalisco',),
               PersonalInfo(title: 'Correo Electrónico', info: 'KarlaPonce@tciconsultoria.mx.onmicrosoft.com',),
               Row(
                children: [
                  
                  Expanded(
                    child: PersonalInfo(title: 'Teléfono de Contacto', info: '(+52) 771 240 7357'),
                  ),
                  const SizedBox(width: 10), 
                  Expanded(
                    child: PersonalInfo(title: 'Antigüedad', info: '2 años 4 meses'),
                  ),
                ],
              ),
               Row(
                children: [
                  
                  Expanded(
                    child: PersonalInfo(title: 'Firma de Contrato', info: '(+52) 771 240 7357'),
                  ),
                  const SizedBox(width: 10), 
                  Expanded(
                    child: PersonalInfo(title: 'Rescisión de Contrato', info: '--/ --- / ----'),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
               Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text('Información Personal', style: titleOsw24Bold500Primary,),
               ),
               const SizedBox(height: 10,),
               PersonalInfo(title: 'Fecha de Nacimiento', info: 'DD/MM/AAAA' ,),
               PersonalInfo(title: 'NSS', info: '23456788976t' ,),
               Row(
                children: [
                  
                  Expanded(
                    child: PersonalInfo(title: 'CURP', info: 'ABEM987654HEMLDOF0'),
                  ),
                  const SizedBox(width: 10), 
                  Expanded(
                    child: PersonalInfo(title: 'RFC', info: 'ABEM987654U40'),
                  ),
                ],
              ),
              LogoutButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PersonalInfo extends StatelessWidget {

  final String title;
  final String info;
  
  const PersonalInfo({
    super.key, required this.title, required this.info,
  });

  @override
  Widget build(BuildContext context) {
    final subtitleOsw16Bold500Secondary = Theme.of(context).textTheme.subtitleOsw16Bold500Secondary;
    final textJt14bold400Grey = Theme.of(context).textTheme.textJt14bold400Grey;
    
    final fontSizedGrow = getResponsiveScaleFactor(context);
    return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       Text(title, style: subtitleOsw16Bold500Secondary.copyWith(fontSize: 16*fontSizedGrow),),
       const SizedBox(height: 5,),
       Container(
         width: double.infinity,
         
         padding: const EdgeInsets.all(10),
         decoration: BoxDecoration(
           color: Colors.grey[200],
           borderRadius: BorderRadius.circular(10)
         ),
         child: Text(info, style: textJt14bold400Grey.copyWith(fontSize: 14*fontSizedGrow),)
       )
     ],
    );
  }
}

class InfoColumn extends StatelessWidget {
  final String title;
  final String description;
  
  
  const InfoColumn({
    super.key, required this.title, required this.description,
  });

  @override
  Widget build(BuildContext context) {

    final subtitleOsw16Bold500Primary = Theme.of(context).textTheme.subtitleOsw16Bold500Primary;
    final titleJt18Bold500Secondary = Theme.of(context).textTheme.titleJt18Bold500Secondary;
    
    final fontSizedGrow = getResponsiveScaleFactor(context);
    return Column(
      children: [
        Text(title, style: subtitleOsw16Bold500Primary.copyWith(fontSize: 16*fontSizedGrow)),
        Text(description, style: titleJt18Bold500Secondary.copyWith(fontSize: 18*fontSizedGrow))
      ],
    );
  }
}