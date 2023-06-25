import 'package:flutter/material.dart';

class PostAddFloatingButton extends StatelessWidget {
  const PostAddFloatingButton({
    super.key,
    required this.onPressed,
  });

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: const Icon(Icons.add),
    );
  }
}
