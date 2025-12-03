import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_gate/pages/pages.dart';
import 'package:time_gate/pages/spash_page.dart';
import 'package:time_gate/providers/tabbar_provider.dart'; 
import 'package:time_gate/themes/app_theme.dart';
import 'package:intl/date_symbol_data_local.dart';  
import './providers/auth_provider.dart';


// void main() => runApp(const MyApp());
void main() {
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TabbarProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'splash',
        routes: {
          'splash': (_) => const SplashPage(),
          'main': (_) => const TabsPage(),
          'login': (_) => const LoginPage(),
          'vacation request': (_) => const VacationRequestPage(),
          'permit application': (_) => const PermitApplicationPage(),
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => const TabsPage(),
          );
        },
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
