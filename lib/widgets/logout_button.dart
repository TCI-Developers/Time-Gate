import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.logout),
      label: const Text('Cerrar sesión'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
      ),
      onPressed: () async {
        final authProvider =
            Provider.of<AuthProvider>(context, listen: false);

        await authProvider.logout();

        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            'splash',
            (_) => false,
          );
        }
      },
    );
  }
}
