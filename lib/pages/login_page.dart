import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_gate/themes/app_theme.dart';
import 'package:time_gate/utils/responsive_utils.dart';
import '../widgets/custom_input_field.dart';
import '../providers/auth_provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double maxContainerWidth = getMaxContentWidth(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Container(
              width: maxContainerWidth,
              padding: const EdgeInsets.only(top: 30, left: 80, right: 80),
              child:  Column(
                children: [
                 
                  Image.asset(
                    'assets/IMAGOTIPO-TIMEGATE.png',
                    width: 350,
                    height: 350,
                    fit: BoxFit.cover,
                    frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                    if (wasSynchronouslyLoaded) return child;

                    return AnimatedOpacity(
                      opacity: frame == null ? 0 : 1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                      child: child,
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.error_outline, size: 50),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Iniciar Sesión',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.secondary,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  FormLogin(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FormLogin extends StatefulWidget {
  const FormLogin({super.key});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();

  final Map<String, String> formValues = {
    'email': '',
    'password': '',
  };

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Form(
      key: myFormKey,
      child: Column(
        children: [
          CustomImputField(
            labelText: 'Correo',
            hintText: 'ejemplo@gmail.com',
            formProperty: 'email',
            formValues: formValues,
          ),
          const SizedBox(height: 20),
          CustomImputField(
            labelText: 'Contraseña',
            hintText: 'Contraseña',
            formProperty: 'password',
            formValues: formValues,
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: authProvider.isLoading ? null : () async {
          
            FocusScope.of(context).unfocus();

            if (!myFormKey.currentState!.validate()) return;

            final nav = Navigator.of(context);
            final messenger = ScaffoldMessenger.of(context);

            final ok = await authProvider.login(
              formValues['email']!,
              formValues['password']!,
            );

            if (ok) {
              nav.pushReplacementNamed('main');
            } else {
              messenger.showSnackBar(
                SnackBar(
                  content: Text(authProvider.errorMessage ?? 'Credenciales incorrectas'),
                  backgroundColor: Colors.redAccent,
                ),
              );
            }
          },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
            ),
            child: SizedBox(
              width: double.infinity,
              child: Center(
                child: authProvider.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Ingresar',
                        style: TextStyle(
                          color: AppTheme.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
