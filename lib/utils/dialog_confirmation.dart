import 'package:flutter/material.dart';

Future<void> dialogConfirm({
  required BuildContext context,
  required String title,
  required String message,
  required VoidCallback onConfirmed,
}) async {
  final bool? confirmed = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false), 
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, true), 
          child: const Text('Confirm'),
        ),
      ],
    ),
  );

  if (confirmed == true) {
    onConfirmed();
  }
}