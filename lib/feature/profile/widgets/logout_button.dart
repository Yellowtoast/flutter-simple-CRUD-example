import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
    required this.onTapLogout,
  });
  final void Function()? onTapLogout;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTapLogout,
      icon: const Icon(Icons.logout),
    );
  }
}
