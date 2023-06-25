import 'package:get/get.dart';
import 'package:tech_test/core/utils/pagination/pagination.dart';
import 'package:tech_test/data/model/post.dart';
import 'package:tech_test/data/repository/post_repository.dart';
import 'package:tech_test/core/utils/pagination/pagination_interface.dart';
import 'package:tech_test/feature/post/arguments/post_detail_argument.dart';
import 'package:tech_test/feature/post/arguments/post_result_argument.dart';
import 'package:tech_test/feature/post/controller/post_detail_controller.dart';
import 'package:tech_test/routes/app_routes.dart';

///
/// [PostRepository]를 인자로 가진다
/// 구현 요구사항
/// - List<Post>를 조회하는 함수
/// - List<Post>를 수정하는 함수
abstract class HomeController {
  final paginationData = Rx<PaginationBase<Post>>(PaginationLoading<Post>());
  void onEndOfPage();
  Future<void> onRefresh();
  Future<void> goToPostEditPage({required int postId});
  Future<void> goToPostAddPage();
  void goToProfilePage();
}

class HomeControllerImpl extends GetxController implements HomeController {
  HomeControllerImpl({required PostRepository postRepository})
      : _postRepository = postRepository;

  final PostRepository _postRepository;

  @override
  final paginationData = Rx<PaginationBase<Post>>(PaginationLoading<Post>());

  static const int _fetchLimit = 20;

  @override
  onInit() {
    super.onInit();
    _paginate(fetchLimit: _fetchLimit);
  }

  @override
  onEndOfPage() {
    _paginate(fetchMore: true, fetchLimit: _fetchLimit);
  }

  @override
  Future<void> onRefresh() async {
    await _paginate(fetchLimit: _fetchLimit, forceRefetch: true);
  }

  _paginate({
    required int fetchLimit,
    bool fetchMore = false,
    bool forceRefetch = false,
  }) {
    PaginationInterface.paginate<Post>(
      fetchMore: fetchMore,
      fetchLimit: fetchLimit,
      forceRefetch: forceRefetch,
      previousPState: paginationData.value,
      onPaginationStateChange: _onPaginationStateChange,
      fetchDataFunction: (paginationRequest) => _postRepository.getPosts(
        limit: paginationRequest.limit,
        offset: paginationRequest.offset,
      ),
    );
  }

  _onPaginationStateChange(PaginationBase<Post> newPaginationState) {
    paginationData.value = newPaginationState;
  }

  @override
  goToPostEditPage({required int postId}) async {
    final result = await Get.toNamed(
      Routes.postDetail,
      arguments: PostDetailArguments(
        postDetailType: PostDetailPageType.edit,
        id: postId,
      ),
    );

    if (result != null) {
      _handlePostDetailResult(result);
    }
  }

  @override
  goToPostAddPage() async {
    final result = await Get.toNamed(
      Routes.postDetail,
      arguments: PostDetailArguments(
        postDetailType: PostDetailPageType.add,
      ),
    );

    if (result != null) {
      _handlePostDetailResult(result);
    }
  }

  @override
  goToProfilePage() {
    Get.toNamed(Routes.profile);
  }

  _handlePostDetailResult(PostDetailPageResult result) {
    assert(
      paginationData.value is PaginationResponse<Post>,
      'paginationData상태가 PaginationResponse일 경우에만 리스트 업데이트 가능',
    );

    if (result is PostAddResultImpl) {
      _addPostToList(addedPost: result.addedPost);
    } else if (result is PostDeleteResultImpl) {
      _deletePostFromList(deletePostId: result.deletedPostId);
    } else if (result is PostEditResultImpl) {
      _updatePostFromList(editedPost: result.editedPost);
    }
  }

  _updatePostFromList({required Post editedPost}) {
    int editedPostIndex =
        (paginationData.value as PaginationResponse<Post>).items.indexWhere(
              (element) => element.id == editedPost.id,
            );
    (paginationData.value as PaginationResponse).items[editedPostIndex] =
        editedPost;
    paginationData.refresh();
  }

  _deletePostFromList({required int deletePostId}) {
    (paginationData.value as PaginationResponse<Post>).items.removeWhere(
          (element) => element.id == deletePostId,
        );
    paginationData.refresh();
  }

  _addPostToList({required Post addedPost}) {
    (paginationData.value as PaginationResponse<Post>)
        .items
        .insert(0, addedPost);
    paginationData.refresh();
  }
}
