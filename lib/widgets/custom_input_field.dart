
import 'package:flutter/material.dart';

class CustomImputField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String formProperty;
  final Map<String, String> formValues;

  
  const CustomImputField({
    super.key, this.hintText, this.labelText, this.helperText, this.suffixIcon, this.prefixIcon, this.keyboardType, this.obscureText =false, required this.formProperty, required this.formValues,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      initialValue: '',
      textCapitalization: TextCapitalization.words,
      keyboardType: keyboardType,
      obscureText: obscureText ,
      
      onChanged: (value){

        formValues[formProperty] = value;
    
      },
      validator: (value) {
        if(value==null) return 'campo requerido';
        return value.length < 3 ? 'Minimo 3 letreas':null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        
        hintText: hintText,
        labelText: labelText,
        helperText: helperText,
        prefixIcon: prefixIcon ==null? null:  Icon(prefixIcon),
        suffixIcon: suffixIcon ==null ? null: Icon(suffixIcon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        )
    
      ),
    
    );
  }
}