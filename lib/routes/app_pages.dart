import 'package:get/route_manager.dart';
import 'package:tech_test/feature/home/binding/home_binding.dart';
import 'package:tech_test/feature/home/home_page.dart';
import 'package:tech_test/feature/login/binding/login_binding.dart';
import 'package:tech_test/feature/login/login_page.dart';
import 'package:tech_test/feature/post/binding/post_detail_binding.dart';
import 'package:tech_test/feature/post/post_detail_page.dart';
import 'package:tech_test/feature/profile/binding/profile_binding.dart';
import 'package:tech_test/feature/profile/profile_page.dart';
import 'package:tech_test/feature/splash/splash_binding.dart';
import 'package:tech_test/feature/splash/splash_page.dart';
import 'package:tech_test/routes/app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashPage(),
      binding: SplashPageBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.postDetail,
      page: () => const PostDetailPage(),
      binding: PostDetailBinding(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),
  ];
}
