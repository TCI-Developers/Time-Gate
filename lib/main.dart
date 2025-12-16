import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:time_gate/pages/pages.dart';
// import 'package:time_gate/pages/spash_page.dart';
import 'package:time_gate/providers/tabbar_provider.dart'; 
import 'package:time_gate/themes/app_theme.dart';
import 'package:intl/date_symbol_data_local.dart';  
import './providers/auth_provider.dart';


// void main() => runApp(const MyApp());
// void main() {
//   initializeDateFormatting().then((_) => runApp(const MyApp()));
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
   
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => TabbarProvider()),
//         ChangeNotifierProvider(create: (_) => AuthProvider()),
//       ],
//       child: MaterialApp(
//         title: 'Material App',
//         debugShowCheckedModeBanner: false,
//         initialRoute: 'splash',
//         routes: {
//           'splash': (_) => const SplashPage(),
//           'main': (_) => const TabsPage(),
//           'login': (_) => const LoginPage(),
//           'vacation request': (_) => const VacationRequestPage(),
//           'permit application': (_) => const PermitApplicationPage(),
//         },
//         onUnknownRoute: (settings) {
//           return MaterialPageRoute(
//             builder: (context) => const TabsPage(),
//           );
//         },
//         theme: AppTheme.lightTheme,
//       ),
//     );
//   }
// }
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await initializeDateFormatting();

  final authProvider = AuthProvider();
  
  // 1. Cargamos la sesión. Aseguramos que sessionExists sea bool, nunca null.
  bool sessionExists = false;
  try {
    sessionExists = await authProvider.loadSession();
  } catch (e) {
    sessionExists = false;
  }

  FlutterNativeSplash.remove();

  // 2. Pasamos la instancia y la ruta decidida
  runApp(MyApp(
    initialRoute: sessionExists ? 'main' : 'login',
    authProvider: authProvider,
  ));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  final AuthProvider authProvider;

  // 3. El constructor requiere ambos parámetros
  const MyApp({
    super.key, 
    required this.initialRoute, 
    required this.authProvider
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TabbarProvider()),
        // 4. USAMOS .value y nos aseguramos de pasarle el objeto recibido
        ChangeNotifierProvider<AuthProvider>.value(value: authProvider),
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: initialRoute,
        routes: {
          'main': (_) => const TabsPage(),
          'login': (_) => const LoginPage(),
          'vacation request': (_) => const VacationRequestPage(),
          'permit application': (_) => const PermitApplicationPage(),
        },
        onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (context) => const TabsPage(),
        ),
        theme: AppTheme.lightTheme,
      ),
    );
  }
}