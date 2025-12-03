import 'package:flutter/material.dart';
import 'package:time_gate/themes/app_theme.dart';

class PauseMenuForm extends StatelessWidget {
  final void Function(String option)? onOptionSelected;
  final void Function(String text)? onSave;

  const PauseMenuForm({super.key, this.onOptionSelected, this.onSave});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    Widget menuItem(String text) {
      return InkWell(
        onTap: () {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Seleccionaste: $text')));
          if (onOptionSelected != null) onOptionSelected!(text);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
   
          padding: const EdgeInsets.only(bottom: 8.0), 
          
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey, 
                width: 1.0,         
              ),
            ),
          ),
          
          // 3. Colocamos el widget Text como hijo
          child: Text(
            text, 
            style: const TextStyle(
              fontSize: 16, 
              fontWeight: FontWeight.bold, 
              color: AppTheme.secondary,
            ),
          ),
        ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.only(left: 10,top: 20, right: 10, bottom: 10),
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
          const SizedBox(height: 10),
          const Text('Otrá', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.secondary),),
          const SizedBox(height: 5),
          TextField(
            controller: controller,
            maxLines: 5,
            minLines: 3,
            decoration: InputDecoration(
              hintText: 'Escribe',
              isDense: true,
              
              // 1. Redondear y definir el borde por defecto (cuando NO está enfocado)
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0), 
                borderSide: const BorderSide(
                  color: Color.fromARGB(181, 158, 158, 158), 
                  width: 1.0,
                ),
              ),
              
              // 2. Redondear y cambiar el color del borde cuando SÍ está enfocado
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0), 
                borderSide: const BorderSide(
                  color: Colors.grey, 
                  width: 2.0,
                ),
              ),
              
              // 3. Controlar el padding interno del hintText/contenido
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 10.0,
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              final text = controller.text.trim();
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Otra razón: $text')));
              if (onSave != null) onSave!(text);
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(AppTheme.primary),
              foregroundColor: WidgetStateProperty.all<Color>(AppTheme.secondary),
            ),
            child: const Text('Guardar'),
            
          ),
        ],
      ),
    );
  }
}

