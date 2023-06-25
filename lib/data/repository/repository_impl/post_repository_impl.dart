import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:tech_test/core/utils/exception/remote_exceptions.dart';
import 'package:tech_test/core/utils/failure/failure.dart';
import 'package:tech_test/core/utils/pagination/pagination.dart';
import 'package:tech_test/data/model/post.dart';
import 'package:tech_test/data/repository/post_repository.dart';

class PostRepositoryImpl extends GetxService implements PostRepository {
  final now = DateTime.now();

  @override
  Future<int> deletePost(int id) =>
      Future.delayed(const Duration(seconds: 1)).then((_) => id);

  @override
  Future<bool> createPost({required String title, required String textBody}) =>
      Future.delayed(const Duration(seconds: 1)).then((_) => true);

  @override
  Future<Post> getPost(int id) =>
      Future.delayed(const Duration(seconds: 1)).then(
        (_) => Post(
          id: id,
          title: 'Post title $id',
          textBody: 'Post textBody $id ' * 20,
          authorName: 'Post $id authorName',
          createdAt: now,
        ),
      );

  @override
  Future<Either<Failure, PaginationBase<Post>>> getPosts(
      {required int limit, required int offset}) async {
    try {
      return await Future.delayed(const Duration(seconds: 1))
          .then((_) => Right(PaginationResponse(
                items: List.generate(offset < 80 ? limit : 0, (index) {
                  int id = offset + index + 1;
                  return Post(
                    id: id,
                    title: 'Post title $id',
                    textBody: 'Post textBody $id',
                    authorName: 'Post $id authorName',
                    createdAt: now,
                  );
                }),
                hasNextPage: offset < 80,
                paginationRequest: PaginationRequest(
                  limit: limit,
                  offset: offset + limit,
                ),
              )));
    } catch (e) {
      return Left(GetPostListFailure(
        code: 500,
        message: 'message',
        retryable: true,
        exception: ServerException(),
      ));
    }
  }

  @override
  Future<Post> updatePost(
          {required int id, required String title, required String textBody}) =>
      Future.delayed(const Duration(seconds: 1)).then(
        (_) => Post(
          id: id,
          title: title,
          textBody: textBody,
          authorName: 'Post $id authorName',
          createdAt: now,
        ),
      );
}

class GetPostListFailure implements Failure {
  @override
  final int code;
  @override
  final String message;

  @override
  final bool retryable;

  @override
  final Exception exception;

  GetPostListFailure(
      {required this.code,
      required this.message,
      required this.retryable,
      required this.exception});
}
