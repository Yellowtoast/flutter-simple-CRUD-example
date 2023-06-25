import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  const EditButton({
    super.key,
    required this.onTap,
    required this.isEditable,
  });

  final void Function() onTap;
  final bool isEditable;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: const Icon(Icons.edit),
    );
  }
}
