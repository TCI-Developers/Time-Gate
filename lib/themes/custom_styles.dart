import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_gate/themes/app_theme.dart';


extension CustomTextStyles on TextTheme {
  
  
TextStyle get titleOsw30Bold30Secondary {
    return GoogleFonts.oswald(
      fontSize: 30,           
      color: AppTheme.secondary,
      fontWeight: FontWeight.bold

    );
  }

  TextStyle get titleOsw30Bold500Secondary {
    return GoogleFonts.oswald(
      fontSize: 30,           
      color: AppTheme.secondary,
      fontWeight: FontWeight.w500,


    );
  }

  TextStyle get titleOsw30Bold30Primary {
    return GoogleFonts.oswald(
      fontSize: 30,           
      color: AppTheme.primary,
      fontWeight: FontWeight.bold

    );
  }

  TextStyle get titleOsw30Bold500Primary {
    return GoogleFonts.oswald(
      fontSize: 30,           
      color: AppTheme.primary,
      fontWeight: FontWeight.w500,


    );
  }

  TextStyle get titleOsw28Bold500Primary {
    return GoogleFonts.oswald(
      fontSize: 28,           
      color: AppTheme.primary,
      fontWeight: FontWeight.w500,


    );
  }

  TextStyle get titleOsw28Bold500Secondary {
    return GoogleFonts.oswald(
      fontSize: 28,           
      color: AppTheme.secondary,
      fontWeight: FontWeight.w500,


    );
  }

  TextStyle get titleOsw24Bold500Secondary {
    return GoogleFonts.oswald(
      fontSize: 24,           
      color: AppTheme.secondary,
      fontWeight: FontWeight.w500,


    );
  }

   TextStyle get titleOsw24Bold500Primary {
    return GoogleFonts.oswald(
      fontSize: 24,           
      color: AppTheme.primary,
      fontWeight: FontWeight.w500,


    );
  }

  TextStyle get titleJt24Bold500Secondary {
    return GoogleFonts.jost(
      fontSize: 24,           
      color: AppTheme.secondary,
      fontWeight: FontWeight.w500,


    );
  }

  TextStyle get titleOsw20Bold500Primary {
    return GoogleFonts.oswald(
      fontSize: 20,           
      color: AppTheme.primary,
      fontWeight: FontWeight.w500,


    );
  }

  TextStyle get titleOsw20Bold500Secondary {
    return GoogleFonts.oswald(
      fontSize: 20,           
      color: AppTheme.secondary,
      fontWeight: FontWeight.w500,


    );
  }

  TextStyle get titleJt20Bold500Secondary {
    return GoogleFonts.jost(
      fontSize: 20,           
      color: AppTheme.secondary,
      fontWeight: FontWeight.w400,


    );
  }

  TextStyle get titleJt20Bold500Grey {
    return GoogleFonts.jost(
      fontSize: 20,           
      color: const Color(0xff878787),
      fontWeight: FontWeight.w400,


    );
  }

  TextStyle get titleOsw18Bold500Secondary {
    return GoogleFonts.oswald(
      fontSize: 18,           
      color: AppTheme.secondary,
      fontWeight: FontWeight.w500,

    );
  }
 

  TextStyle get titleOsw18Bold400Secondary {
    return GoogleFonts.oswald(
      fontSize: 18,           
      color: AppTheme.secondary,
      fontWeight: FontWeight.w400,

    );
  }

  TextStyle get titleJt18Bold500Secondary {
    return GoogleFonts.jost(
      fontSize: 18,           
      color: AppTheme.secondary,
      fontWeight: FontWeight.w500,

    );
  }

  TextStyle get titleJt18Bold700White {
    return GoogleFonts.jost(
      fontSize: 18,           
      color: AppTheme.white,
      fontWeight: FontWeight.w700,

    );
  }




  TextStyle get titleOsw18Bold500Primary {
    return GoogleFonts.oswald(
      fontSize: 18,           
      color: AppTheme.primary,
      fontWeight: FontWeight.w500,

    );
  }

  TextStyle get textJt18bold400Grey {
    return GoogleFonts.jost(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF797979)
  
    );
  }


  TextStyle get subtitleOsw16Bold500Secondary {
    return GoogleFonts.oswald(
      fontSize: 16,           
      color: AppTheme.secondary,
      fontWeight: FontWeight.w500

    );
  }

  TextStyle get subtitleOsw16Bold500Primary {
    return GoogleFonts.oswald(
      fontSize: 16,           
      color: AppTheme.primary,
      fontWeight: FontWeight.w500

    );
  }


  TextStyle get textJt16bold400Grey {
    return GoogleFonts.jost(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF797979)
     
    );
  }

  TextStyle get textJt16bold400Secondary {
    return GoogleFonts.jost(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppTheme.secondary
     
    );
  }
  TextStyle get textJt16bold700Secondary {
    return GoogleFonts.jost(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: AppTheme.secondary
     
    );
  }

  TextStyle get textJt16bold400White {
    return GoogleFonts.jost(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppTheme.white
     
    );
  }

  TextStyle get textOsw14bold500Primary {
    return GoogleFonts.oswald(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppTheme.primary
     
    );
  }

  TextStyle get textJt14bold400Na {
    return GoogleFonts.jost(
      fontSize: 14,
      fontWeight: FontWeight.w400,
     
    );
  }

   TextStyle get textOsw14bold400Na {
    return GoogleFonts.oswald(
      fontSize: 14,
      fontWeight: FontWeight.w400,
    
     
    );
  }

  TextStyle get textJt14bold400Grey {
    return GoogleFonts.jost(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: const Color(0xff878787)
       // Regular
    );
  }
  

  TextStyle get textJt13bold400Secondary {
    return GoogleFonts.jost(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: AppTheme.secondary
     
    );
  }

   TextStyle get textOsw12bold500Primary {
    return GoogleFonts.oswald(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppTheme.primary
     
    );
  }

  TextStyle get textOsw12bold400Secondary {
    return GoogleFonts.oswald(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppTheme.secondary
       // Regular
    );
  }

  TextStyle get textOsw12boldPrimary{
    return GoogleFonts.oswald(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: AppTheme.primary
      
    );
  }

  TextStyle get textJt12bold400Secondary {
    return GoogleFonts.jost(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppTheme.secondary
     
    );
  }

  TextStyle get textJt12bold400White {
    return GoogleFonts.jost(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppTheme.white
     
    );
  }
  TextStyle get textOsw11boldPrimary{
    return GoogleFonts.oswald(
      fontSize: 11,
      fontWeight: FontWeight.bold,
      color: AppTheme.primary
      
    );
  }


  TextStyle get textOsw11bold400Secondary {
    return GoogleFonts.oswald(
      fontSize: 11,
      fontWeight: FontWeight.w400,
      color: AppTheme.secondary
       // Regular
    );
  }

  TextStyle get textJt11bold400Secondary {
    return GoogleFonts.jost(
      fontSize: 11,
      fontWeight: FontWeight.w400,
      color: AppTheme.secondary
       // Regular
    );
  }

  TextStyle get textJt10boldNormalSecondary {
    return GoogleFonts.jost(
      fontSize: 10,
      fontWeight: FontWeight.normal,
      color: AppTheme.secondary
     
    );
  }

}



  