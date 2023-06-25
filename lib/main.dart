import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_test/app.dart';
import 'package:tech_test/data/repository/repository_impl/auth_repository_impl.dart';
import 'package:tech_test/data/repository/repository_impl/local_repository_impl.dart';
import 'package:tech_test/data/repository/repository_impl/post_repository_impl.dart';

Future<void> main() async {
  await _initRepository();
  runApp(const App());
}

_initRepository() async {
  await Get.put(LocalRepositoryImpl()).initHive();
  Get.lazyPut(() => AuthRepositoryImpl());
  Get.lazyPut(() => PostRepositoryImpl());
}
