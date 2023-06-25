import 'package:get/get.dart';
import 'package:tech_test/data/repository/repository_impl/local_repository_impl.dart';
import 'package:tech_test/feature/splash/splash_page_controller.dart';

class SplashPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashPageController>(
      SplashPageControllerImpl(
          localRepository: Get.find<LocalRepositoryImpl>()),
    );
  }
}
