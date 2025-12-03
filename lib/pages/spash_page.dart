// lib/pages/splash_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_gate/themes/app_theme.dart';
import '../providers/auth_provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final sessionExists = await authProvider.loadSession();

    if (!mounted) return;

    Navigator.pushReplacementNamed(
      context,
      sessionExists ? 'main' : 'login',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.secondary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
                image: AssetImage('assets/IMAGOTIPO-TIMEGATE.png'),
                width: 350,
                height: 350,
                fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
