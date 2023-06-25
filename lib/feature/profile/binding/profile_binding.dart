import 'package:get/get.dart';
import 'package:tech_test/data/repository/repository_impl/auth_repository_impl.dart';
import 'package:tech_test/data/repository/repository_impl/local_repository_impl.dart';
import 'package:tech_test/feature/profile/profile_page_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ProfilePageController>(
      ProfilePageControllerImpl(
        authRepository: Get.find<AuthRepositoryImpl>(),
        localRepository: Get.find<LocalRepositoryImpl>(),
      ),
    );
  }
}
