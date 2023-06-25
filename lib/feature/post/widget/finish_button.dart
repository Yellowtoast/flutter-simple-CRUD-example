import 'package:flutter/material.dart';

class FinishButton extends StatelessWidget {
  const FinishButton({
    super.key,
    required this.isButtonValid,
    required this.buttonText,
    this.onPressed,
  });

  final void Function()? onPressed;
  final bool isButtonValid;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (isButtonValid) ? onPressed : null,
      child: Text(buttonText),
    );
  }
}
