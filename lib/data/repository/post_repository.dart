import 'package:dartz/dartz.dart';
import 'package:tech_test/core/utils/failure/failure.dart';
import 'package:tech_test/core/utils/pagination/pagination.dart';
import 'package:tech_test/data/model/post.dart';

abstract class PostRepository {
  Future<Either<Failure, PaginationBase<Post>>> getPosts(
      {required int limit, required int offset});

  Future<bool> createPost({required String title, required String textBody});

  Future<Post> getPost(int id);

  Future<int> deletePost(int id);

  Future<Post> updatePost({
    required int id,
    required String title,
    required String textBody,
  });
}
