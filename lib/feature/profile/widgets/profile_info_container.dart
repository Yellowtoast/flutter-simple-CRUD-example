import 'package:flutter/material.dart';

class ProfileInfoContainer extends StatelessWidget {
  const ProfileInfoContainer({
    super.key,
    required this.email,
    required this.name,
  });

  final String email;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey.withOpacity(0.2),
          child: Icon(
            Icons.person,
            size: 50,
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          '아이디',
          style: TextStyle(fontSize: 15),
        ),
        const SizedBox(height: 3),
        Text(
          email,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
        const Text(
          '이름',
          style: TextStyle(fontSize: 15),
        ),
        const SizedBox(height: 5),
        Text(
          name,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
