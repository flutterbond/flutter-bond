import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    this.enabled = true,
    this.loading = false,
    required this.onPressed,
  });

  final String title;
  final bool enabled;
  final bool loading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
      child: loading
          ? const CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            )
          : Text(title),
    );
  }
}
