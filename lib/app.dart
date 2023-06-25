import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_test/routes/app_pages.dart';
import 'package:tech_test/routes/app_routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '금융기술팀 Flutter test',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
      getPages: AppPages.routes,
    );
  }
}
