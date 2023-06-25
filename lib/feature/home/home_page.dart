import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_test/data/model/post.dart';
import 'package:tech_test/feature/home/controller/home_controller.dart';
import 'package:tech_test/core/widgets/paginated_list_view.dart';
import 'package:tech_test/feature/home/widgets/post_add_floating_button.dart';
import 'package:tech_test/feature/home/widgets/post_list_tile.dart';
import 'package:tech_test/feature/home/widgets/profile_button.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
        actions: [
          ProfileButton(
            onPressed: controller.goToProfilePage,
          ),
        ],
      ),
      body: Obx(
        () => PaginatedListView<Post>(
          state: controller.paginationData.value,
          successBuilder: (post, index) => PostListTile(
            onTapPost: (postId) => controller.goToPostEditPage(
              postId: postId,
            ),
            post: post,
          ),
          onEndOfPage: controller.onEndOfPage,
          onRefresh: controller.onRefresh,
        ),
      ),
      floatingActionButton: PostAddFloatingButton(
        onPressed: controller.goToPostAddPage,
      ),
    );
  }
}
