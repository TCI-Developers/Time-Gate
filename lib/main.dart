import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:time_gate/pages/pages.dart';
import 'package:time_gate/providers/attendance_provider.dart';
import 'package:time_gate/providers/home_provider.dart';
import 'package:time_gate/providers/profile_provider.dart';
import 'package:time_gate/providers/tabbar_provider.dart'; 
import 'package:time_gate/themes/app_theme.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:time_gate/utils/navigation_service.dart';
import './providers/auth_provider.dart';

// void main() async {
//   WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
//   FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

//   await initializeDateFormatting();

//   final authProvider = AuthProvider();
  
//   bool sessionExists = false;
//   try {
//     sessionExists = await authProvider.loadSession();
//   } catch (e) {
//     sessionExists = false;
//   }

//   FlutterNativeSplash.remove();

//   runApp(MyApp(
//     initialRoute: sessionExists ? 'main' : 'login',
//     authProvider: authProvider,
//   ));
// }

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // Mantenemos el splash hasta que nosotros decidamos quitarlo
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await initializeDateFormatting();

  runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   final String initialRoute;
//   final AuthProvider authProvider;

//   // 3. El constructor requiere ambos parámetros
//   const MyApp({
//     super.key, 
//     required this.initialRoute, 
//     required this.authProvider
//   });

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => TabbarProvider()),
//         ChangeNotifierProvider<AuthProvider>.value(value: authProvider),
//         ChangeNotifierProvider(create: (_) => ProfileProvider()),
//         ChangeNotifierProvider(create: (_) => HomeProvider()),
//         ChangeNotifierProvider(create: (_) => AttendanceProvider()),

//       ],
//       child: MaterialApp(
//         title: 'Material App',
//         debugShowCheckedModeBanner: false,
//         initialRoute: initialRoute,
//         navigatorKey: navigatorKey,
//         routes: {
//           'main': (_) => const TabsPage(),
//           'login': (_) => const LoginPage(),
//           'vacation request': (_) => const VacationRequestPage(),
//           'permit application': (_) => const PermitApplicationPage(),
//         },
//         onUnknownRoute: (settings) => MaterialPageRoute(
//           builder: (context) => const TabsPage(),
//         ),
//         theme: AppTheme.lightTheme,
//       ),
//     );
//   }
// }
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MultiProvider envuelve a toda la App, así LoginPage siempre encontrará los providers
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TabbarProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => AttendanceProvider()),
      ],
      child: MaterialApp(
        title: 'Time Gate',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        // AuthWrapper decidirá si mostrar Login o Main
        home: const AuthWrapper(), 
        routes: {
          'main': (_) => const TabsPage(),
          'login': (_) => const LoginPage(),
          'vacation request': (_) => const VacationRequestPage(),
          'permit application': (_) => const PermitApplicationPage(),
        },
        theme: AppTheme.lightTheme,
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenemos el provider sin escuchar cambios continuos aquí
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return FutureBuilder<bool>(
      future: authProvider.loadSession(),
      builder: (context, snapshot) {
        // Mientras carga el token y valida en el servidor
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Una vez tenemos respuesta, quitamos el splash nativo
        FlutterNativeSplash.remove();

        // Si el token es válido, mostramos Main, si no, Login
        if (snapshot.data == true) {
          return const TabsPage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}