
import 'package:flutter/material.dart';

class AppTheme {

  static const Color primary = Color(0xFFfcA310);
  static const Color secondary = Color(0xFF0e245f);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFFE5E5E5);
  static const Color white = Color(0xFFFFFFFF);
  static const Color green = Color(0xFF758E4F);
  static const Color red = Color(0xFF9E2A2B);

  static final ThemeData lightTheme = ThemeData.light().copyWith(

    primaryColor: primary,

  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(

    primaryColor: primary,
    
  );
}
