import 'package:get/get.dart';
import 'package:tech_test/data/repository/repository_impl/post_repository_impl.dart';
import 'package:tech_test/feature/post/arguments/post_detail_argument.dart';
import 'package:tech_test/feature/post/controller/post_detail_controller.dart';

class PostDetailBinding extends Bindings {
  @override
  void dependencies() {
    assert(Get.arguments is PostDetailArguments);

    final argument = Get.arguments as PostDetailArguments;

    assert(
        (argument.postDetailType == PostDetailPageType.edit &&
                argument.id != null) ||
            argument.postDetailType == PostDetailPageType.add,
        '수정/삭제 모드로 진입할 경우 반드시 id 값을 가지고 있어야 함');

    Get.put<PostDetailController>(
      PostDetailControllerImpl(argument, Get.find<PostRepositoryImpl>()),
    );
  }
}
