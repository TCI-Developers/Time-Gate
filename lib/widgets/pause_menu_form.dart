// import 'package:flutter/material.dart';
// import 'package:time_gate/themes/app_theme.dart';

// class PauseMenuForm extends StatelessWidget {
//   final void Function(String option)? onOptionSelected;
//   final void Function(String text)? onSave;

//   const PauseMenuForm({super.key, this.onOptionSelected, this.onSave});

//   @override
//   Widget build(BuildContext context) {
//     final controller = TextEditingController();

//     Widget menuItem(String text) {
//       return InkWell(
//         onTap: () {
//           if (onOptionSelected != null) onOptionSelected!(text);
//         },
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8),
//           child: Container(
   
//           padding: const EdgeInsets.only(bottom: 8.0), 
          
//           decoration: const BoxDecoration(
//             border: Border(
//               bottom: BorderSide(
//                 color: Colors.grey, 
//                 width: 1.0,         
//               ),
//             ),
//           ),
          
//           // 3. Colocamos el widget Text como hijo
//           child: Text(
//             text, 
//             style: const TextStyle(
//               fontSize: 16, 
//               fontWeight: FontWeight.bold, 
//               color: AppTheme.secondary,
//             ),
//           ),
//         ),
//         ),
//       );
//     }

//     return Container(
//       padding: const EdgeInsets.only(left: 10,top: 20, right: 10, bottom: 10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Colors.blueAccent, width: 1),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           menuItem('Trayecto (Cliente)'),
//           menuItem('Comida'),
//           const SizedBox(height: 10),
//           const Text('Otrá', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.secondary),),
//           const SizedBox(height: 5),
//           TextField(
//             controller: controller,
//             maxLines: 5,
//             minLines: 3,
//             decoration: InputDecoration(
//               hintText: 'Escribe',
//               isDense: true,
              
//               // 1. Redondear y definir el borde por defecto (cuando NO está enfocado)
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15.0), 
//                 borderSide: const BorderSide(
//                   color: Color.fromARGB(181, 158, 158, 158), 
//                   width: 1.0,
//                 ),
//               ),
              
//               // 2. Redondear y cambiar el color del borde cuando SÍ está enfocado
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15.0), 
//                 borderSide: const BorderSide(
//                   color: Colors.grey, 
//                   width: 2.0,
//                 ),
//               ),
              
//               // 3. Controlar el padding interno del hintText/contenido
//               contentPadding: const EdgeInsets.symmetric(
//                 vertical: 10.0,
//                 horizontal: 10.0,
//               ),
//             ),
//           ),
//           const SizedBox(height: 10),
//           ElevatedButton(
//             onPressed: () {
//               final text = controller.text.trim();
//               if (onSave != null) onSave!(text);
//             },
//             style: ButtonStyle(
//               backgroundColor: WidgetStateProperty.all<Color>(AppTheme.primary),
//               foregroundColor: WidgetStateProperty.all<Color>(AppTheme.secondary),
//             ),
//             child: const Text('Guardar'),
            
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:time_gate/themes/app_theme.dart';

class PauseMenuForm extends StatelessWidget {
  final void Function(String option)? onOptionSelected;
  final void Function(String save)? onSave;

  const PauseMenuForm({super.key, this.onOptionSelected, this.onSave});

  @override
  Widget build(BuildContext context) {
    Widget menuItem(String text, {VoidCallback? customTap}) {
      return InkWell(
        onTap: customTap ?? () => onOptionSelected?.call(text),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            padding: const EdgeInsets.only(bottom: 8.0),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey, width: 1.0)),
            ),
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.secondary),
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blueAccent, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          menuItem('Trayecto (Cliente)'),
          menuItem('Comida'),
          menuItem('Otra', customTap: () {
          if (onOptionSelected != null) onOptionSelected!('Otra'); 
        }),
        ],
      ),
    );
  }

  // void _showOtraModal(BuildContext context) {
  //   final TextEditingController controller = TextEditingController();

  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: Colors.white,
  //     shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
  //     builder: (context) {
  //       return StatefulBuilder(
  //         builder: (context, setModalState) {
  //           return Padding(
  //             padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 20),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 // Cabecera con título y la X para cerrar
  //                 Padding(
  //                   padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       const Text('Otra actividad', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
  //                       IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
  //                     ],
  //                   ),
  //                 ),
  //                 const Divider(),
  //                 Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.stretch,
  //                     children: [
  //                       TextField(
  //                         controller: controller,
  //                         maxLines: 3,
  //                         autofocus: true,
  //                         onChanged: (val) => setModalState(() {}),
  //                         decoration: InputDecoration(
  //                           hintText: 'Escribe el motivo...',
  //                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
  //                         ),
  //                       ),
  //                       const SizedBox(height: 15),
  //                       ElevatedButton(
  //                         // Se habilita solo si hay texto escrito
  //                         onPressed: controller.text.trim().isEmpty 
  //                           ? null 
  //                           : () {
  //                               if (onSave != null) onSave!(controller.text.trim());
  //                               Navigator.pop(context); // Cierra el modal
  //                             },
  //                         style: ElevatedButton.styleFrom(
  //                           backgroundColor: AppTheme.primary,
  //                           padding: const EdgeInsets.symmetric(vertical: 15),
  //                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //                         ),
  //                         child: const Text('GUARDAR', style: TextStyle(color: Colors.white)),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
}