import 'package:flutter/material.dart';

// Definiciones de los anchos de contenido deseados
const double kDesktopContentWidth = 1000;
const double kTabletContentWidth = 800;

double getMaxContentWidth(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  
  if (screenWidth >= 1024) {
    return kDesktopContentWidth;
  } else if (screenWidth >= 481) {
    return kTabletContentWidth;
  } else {
    return 400;
  }
  
}

double getResponsiveScaleFactor(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;

  if (screenWidth >= 1024) {
    return 1.9; 
  } else if (screenWidth >= 481) {
    return 1.3; 
  }else if(screenWidth >= 581){
    return 1.6;
  }else{
    return 1.0;
  }
}