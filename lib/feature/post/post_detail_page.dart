import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_test/feature/post/controller/post_detail_controller.dart';
import 'package:tech_test/feature/post/widget/delete_button.dart';
import 'package:tech_test/feature/post/widget/edit_button.dart';
import 'package:tech_test/feature/post/widget/finish_button.dart';
import 'package:tech_test/feature/post/widget/text_body_text_field.dart';
import 'package:tech_test/feature/post/widget/title_text_field.dart';

class PostDetailPage extends GetView<PostDetailController> {
  const PostDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post ${controller.postDetailType.name}'),
        actions: (controller.postDetailType == PostDetailPageType.add)
            ? null
            : [
                EditButton(
                  isEditable: controller.isEditable.value,
                  onTap: controller.onTapEditButton,
                ),
                DeleteButton(
                  onTap: controller.onTapDeleteButton,
                )
              ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Obx(() => PostTitleTextField(
                  isEditable: controller.isEditable.value,
                  onChanged: controller.onTitleChanged,
                  onTapClearText: controller.clearTitle,
                  textEditingController: controller.titleController,
                )),
            const SizedBox(height: 16),
            Obx(
              () => PostTextBodyTextField(
                isEditable: controller.isEditable.value,
                onChanged: controller.onTextBodyChanged,
                onTapClearText: controller.clearBodyText,
                textEditingController: controller.textBodyController,
              ),
            ),
            const SizedBox(height: 16),
            Obx(
              () => Visibility(
                visible: controller.isEditable.value,
                child: FinishButton(
                  buttonText: controller.postDetailType.name,
                  isButtonValid: controller.isButtonValid.value,
                  onPressed: controller.onTapFinishButton,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
