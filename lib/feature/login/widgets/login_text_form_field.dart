import 'package:flutter/material.dart';

class LoginTextFormField extends StatelessWidget {
  const LoginTextFormField({
    super.key,
    required this.textEditingController,
    required this.onTapClear,
    required this.onTextChanged,
    required this.label,
    required this.maxLength,
    this.textInputAction,
    this.obscureText,
  });

  final TextEditingController textEditingController;

  final void Function() onTapClear;

  final void Function(String) onTextChanged;

  final String label;

  final int maxLength;

  final TextInputAction? textInputAction;

  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      controller: textEditingController,
      onChanged: onTextChanged,
      textInputAction: textInputAction,
      maxLength: maxLength,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        label: Text(label),
        counterText: '',
        suffixIcon: InkWell(
          onTap: onTapClear,
          child: const Icon(Icons.cancel),
        ),
      ),
    );
  }
}
