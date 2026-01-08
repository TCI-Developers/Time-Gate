import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:time_gate/pages/pages.dart';
import 'package:time_gate/providers/home_provider.dart';
import 'package:time_gate/providers/profile_provider.dart';
import 'package:time_gate/providers/tabbar_provider.dart'; 
import 'package:time_gate/themes/app_theme.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:time_gate/utils/navigation_service.dart';
// import 'package:time_gate/utils/navigation_service.dart';  
import './providers/auth_provider.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await initializeDateFormatting();

  final authProvider = AuthProvider();
  
  bool sessionExists = false;
  try {
    sessionExists = await authProvider.loadSession();
  } catch (e) {
    sessionExists = false;
  }

  FlutterNativeSplash.remove();

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
        ChangeNotifierProvider<AuthProvider>.value(value: authProvider),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),

      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: initialRoute,
        navigatorKey: navigatorKey,
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