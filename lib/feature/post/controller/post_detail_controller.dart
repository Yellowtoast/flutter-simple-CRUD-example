import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_test/data/model/post.dart';
import 'package:tech_test/data/repository/post_repository.dart';
import 'package:tech_test/feature/post/arguments/post_detail_argument.dart';
import 'package:tech_test/feature/post/arguments/post_result_argument.dart';
import 'package:tech_test/core/utils/mixin/dialog_mixin.dart';
import 'package:tech_test/core/utils/mixin/loading_mixin.dart';

enum PostDetailPageType {
  edit('수정'),
  add('작성'),
  delete('삭제');

  const PostDetailPageType(this.name);

  final String name;
}

/// [PostRepository]를 인자로 가진다
/// 구현 요구사항
/// - Post를 생성하는 함수
/// - Post를 조회하는 함수
/// - Post를 수정하는 함수
/// - Post를 삭제하는 함수
abstract class PostDetailController extends GetxController {
  PostDetailPageType get postDetailType;

  final RxBool isButtonValid = false.obs;

  final TextEditingController textBodyController = TextEditingController();

  final TextEditingController titleController = TextEditingController();

  final RxBool isEditable = false.obs;

  void onTitleChanged(String title);

  void onTextBodyChanged(String textBody);

  void onTapEditButton();

  void clearTitle();

  void clearBodyText();

  void onTapFinishButton();

  Future<void> onTapDeleteButton();
}

class PostDetailControllerImpl extends GetxController
    with DialogMixin, LoadingMixin
    implements PostDetailController {
  PostDetailControllerImpl(
    this._arguments,
    this._postRepository,
  );
  final PostRepository _postRepository;

  final PostDetailArguments _arguments;

  final Rx<Post> editedPostDetail = Post(
          id: -1,
          title: '',
          textBody: '',
          authorName: '',
          createdAt: DateTime.now())
      .obs;

  late final Post originalPostDetail;

  @override
  PostDetailPageType get postDetailType => _arguments.postDetailType;

  @override
  final isButtonValid = false.obs;

  @override
  final TextEditingController textBodyController = TextEditingController();

  @override
  final TextEditingController titleController = TextEditingController();

  @override
  RxBool isEditable = false.obs;

  @override
  void onInit() {
    super.onInit();
    isEditable.value =
        (postDetailType == PostDetailPageType.add) ? true : false;
  }

  @override
  void onReady() {
    super.onReady();

    /// 게시물 수정/삭제 모드로 들어온 경우, id에 해당하는 글을 불러와서 세팅합니다
    if (_arguments.postDetailType == PostDetailPageType.edit) {
      showDataLoadingOverlay(
          asyncFunction: () => _setPostDetail(id: _arguments.id!));
    }
    ever(editedPostDetail, _validateFinishButton);
  }

  @override
  onClose() {
    titleController.dispose();
    textBodyController.dispose();
    super.onClose();
  }

  _setPostDetail({required int id}) async {
    editedPostDetail.value = await _postRepository.getPost(id);
    titleController.text = editedPostDetail.value.title;
    textBodyController.text = editedPostDetail.value.textBody;
  }

  _validateFinishButton(Post newPost) {
    if (newPost.title.isNotEmpty && newPost.textBody.isNotEmpty) {
      isButtonValid.value = true;
    } else {
      isButtonValid.value = false;
    }
  }

  @override
  onTitleChanged(String title) {
    editedPostDetail.value = editedPostDetail.value.copyWith(title: title);
  }

  @override
  onTextBodyChanged(String textBody) {
    editedPostDetail.value =
        editedPostDetail.value.copyWith(textBody: textBody);
  }

  @override
  onTapEditButton() async {
    assert(postDetailType == PostDetailPageType.edit,
        'edit 모드에서만 해당 함수에 접근할 수 있습니다');

    isEditable.value = !isEditable.value;
  }

  @override
  onTapDeleteButton() async {
    final confirm = await showTwoButtonDialog(
      cancleText: '취소',
      confirmText: '삭제',
      titleText: '게시글을 삭제하시겠습니까?',
    );

    if (confirm != null && confirm) {
      _deletePost(editedPostDetail.value);
    }
  }

  @override
  clearTitle() {
    titleController.clear();
    onTitleChanged('');
  }

  @override
  clearBodyText() {
    textBodyController.clear();
    onTextBodyChanged('');
  }

  @override
  onTapFinishButton() {
    switch (postDetailType) {
      case PostDetailPageType.add:
        _addPost(newPost: editedPostDetail.value);
        break;
      case PostDetailPageType.edit:
        _editPost(post: editedPostDetail.value);
        break;
      default:
    }
  }

  _addPost({required Post newPost}) async {
    final succees = await showDataLoadingOverlay(
        asyncFunction: () => _postRepository.createPost(
            title: newPost.title, textBody: newPost.textBody));

    if (succees) {
      /// 새로운 게시물은 hascode를 아이디로 가집니다.
      Get.back<PostDetailPageResult>(
          result: PostAddResultImpl(
        addedPost: editedPostDetail.value.copyWith(
            id: editedPostDetail.value.hashCode,
            createdAt: DateTime.now(),
            title:
                'Post title ${editedPostDetail.value.hashCode} / ${editedPostDetail.value.title}',
            textBody:
                'Post textBody ${editedPostDetail.value.hashCode} / ${editedPostDetail.value.textBody}'),
      ));
    }
  }

  _editPost({required Post post}) async {
    final editedPost = await showDataLoadingOverlay(
        asyncFunction: () => _postRepository.updatePost(
              id: post.id,
              title: post.title,
              textBody: post.textBody,
            ));

    Get.back<PostDetailPageResult>(
        result: PostEditResultImpl(editedPost: editedPost));
  }

  _deletePost(Post deletePost) async {
    final deletedPostId = await showDataLoadingOverlay(
        asyncFunction: () => _postRepository.deletePost(
              deletePost.id,
            ));

    Get.back<PostDetailPageResult>(
        result: PostDeleteResultImpl(
      deletedPostId: deletedPostId,
    ));
  }
}
