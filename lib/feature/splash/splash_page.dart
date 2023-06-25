import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_test/feature/splash/splash_page_controller.dart';

/// SplashPage에서 저장된 토큰을 검사합니다.
class SplashPage extends GetView<SplashPageController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'Splash Page',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
