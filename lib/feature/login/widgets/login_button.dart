import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.active,
    required this.onTapButton,
  });

  final bool active;
  final void Function() onTapButton;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (active) ? onTapButton : null,
      child: const Text('Login'),
    );
  }
}
