import 'package:get/get.dart';
import 'package:tech_test/data/repository/repository_impl/auth_repository_impl.dart';
import 'package:tech_test/data/repository/repository_impl/local_repository_impl.dart';
import 'package:tech_test/feature/login/controller/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(
      LoginControllerImpl(
        authRepository: Get.find<AuthRepositoryImpl>(),
        localRepository: Get.find<LocalRepositoryImpl>(),
      ),
    );
  }
}
