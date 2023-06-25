import 'package:tech_test/data/model/post.dart';
import 'package:tech_test/feature/post/controller/post_detail_controller.dart';

abstract class PostDetailPageResult {
  PostDetailPageResult({required this.postDetailType});
  final PostDetailPageType postDetailType;
}

class PostDeleteResultImpl implements PostDetailPageResult {
  @override
  PostDetailPageType get postDetailType => PostDetailPageType.delete;

  final int deletedPostId;

  PostDeleteResultImpl({required this.deletedPostId});
}

class PostEditResultImpl implements PostDetailPageResult {
  @override
  PostDetailPageType get postDetailType => PostDetailPageType.edit;

  final Post editedPost;

  PostEditResultImpl({required this.editedPost});
}

class PostAddResultImpl implements PostDetailPageResult {
  @override
  PostDetailPageType get postDetailType => PostDetailPageType.add;

  final Post addedPost;

  PostAddResultImpl({required this.addedPost});
}
