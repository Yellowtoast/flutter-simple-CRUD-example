import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:tech_test/core/utils/exception/remote_exceptions.dart';
import 'package:tech_test/core/utils/failure/failure.dart';
import 'package:tech_test/data/model/auth.dart';
import 'package:tech_test/data/repository/auth_repository.dart';

class AuthRepositoryImpl extends GetxService implements AuthRepository {
  @override
  Future<Either<Failure, Authentication>> login(
      {required String email, required String password}) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        throw NoAuthorizedException();
      }

      await Future.delayed(const Duration(seconds: 2));

      DateTime now = DateTime.now();
      DateTime expiredDate = DateTime(now.year, now.month, now.day, now.hour,
          now.minute + const Duration(minutes: 3).inMinutes);

      return Right(Authentication(token: '토큰', expiredDate: expiredDate));
    } on RemoteException catch (e) {
      return Left(LogoutFailure(
        code: 400,
        message: '로그아웃에 실패하였습니다',
        retryable: false,
        exception: e,
      ));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      return const Right(true);
    } on RemoteException catch (e) {
      return Left(LogoutFailure(
          code: e.code, message: e.message, retryable: true, exception: e));
    } catch (e) {
      return Left(LogoutFailure(
        code: 400,
        message: '로그아웃에 실패하였습니다',
        retryable: false,
        exception: NoAuthorizedException(),
      ));
    }
  }
}

class LoginFailure implements Failure {
  @override
  final int code;
  @override
  final String message;

  @override
  final bool retryable;

  @override
  final Exception exception;

  LoginFailure({
    required this.code,
    required this.message,
    required this.retryable,
    required this.exception,
  });
}

class LogoutFailure implements Failure {
  @override
  final int code;
  @override
  final String message;

  @override
  final bool retryable;

  @override
  final Exception exception;

  LogoutFailure({
    required this.code,
    required this.message,
    required this.retryable,
    required this.exception,
  });
}
