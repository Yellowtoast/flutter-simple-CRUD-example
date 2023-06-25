import 'package:flutter/material.dart';

class PostTextBodyTextField extends StatelessWidget {
  const PostTextBodyTextField({
    super.key,
    required this.isEditable,
    required this.textEditingController,
    required this.onChanged,
    required this.onTapClearText,
  });

  final bool isEditable;
  final TextEditingController textEditingController;
  final void Function(String)? onChanged;
  final void Function()? onTapClearText;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isEditable,
      child: TextFormField(
        key: const Key('textBodyTextField'),
        controller: textEditingController,
        textInputAction: TextInputAction.done,
        maxLength: 300,
        maxLines: 10,
        enabled: true,
        onChanged: onChanged,
        decoration: InputDecoration(
          label: const Text('textBody'),
          counterText: '',
          suffixIcon: InkWell(
            onTap: onTapClearText,
            child: const Icon(Icons.cancel),
          ),
        ),
      ),
    );
  }
}
