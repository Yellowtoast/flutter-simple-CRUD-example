import 'package:get/get.dart';
import 'package:tech_test/data/repository/repository_impl/post_repository_impl.dart';
import 'package:tech_test/feature/home/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(
      HomeControllerImpl(
        postRepository: Get.find<PostRepositoryImpl>(),
      ),
    );
  }
}
