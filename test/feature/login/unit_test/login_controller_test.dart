// ignore_for_file: unnecessary_cast

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tech_test/core/utils/exception/remote_exceptions.dart';
import 'package:tech_test/data/model/auth.dart';
import 'package:tech_test/data/model/user.dart';
import 'package:tech_test/data/repository/auth_repository.dart';
import 'package:tech_test/data/repository/local_repository.dart';
import 'package:tech_test/data/repository/post_repository.dart';
import 'package:tech_test/data/repository/repository_impl/auth_repository_impl.dart';
import 'package:tech_test/feature/login/controller/login_controller.dart';
import 'login_controller_test.mocks.dart';

@GenerateMocks([AuthRepository, LocalRepository, PostRepository])
void main() {
  /// - 로그인 성공 테스트
  /// - 로그인 실패 테스트
  /// - 로그아웃 성공 테스트
  /// - 로그아웃 실패 테스트

  final now = DateTime.now();

  final authRepository = MockAuthRepository();
  final localRepository = MockLocalRepository();
  final loginController = Get.put(LoginControllerImpl(
      authRepository: authRepository, localRepository: localRepository));

  setUp(() {
    Get.put(authRepository as AuthRepository);
    Get.put(localRepository as LocalRepository);
  });

  tearDown(Get.reset);

  group('LoginController 테스트', () {
    group('Happy Path', () {
      test('로그인 성공 테스트', () async {
        when(
          authRepository.login(
            email: 'test@test.com',
            password: 'password',
          ),
        ).thenAnswer((realInvocation) async {
          return Right(
            Authentication(expiredDate: now, token: 'token'),
          );
        });
        final auth = await loginController.login(
            loginInfo: LoginInfo(email: 'test@test.com', password: 'password'));

        final user = auth.fold(
          (failure) => failure,
          (user) => user,
        );

        expect(
          user,
          User(
            email: 'test@test.com',
            auth: Authentication(
              token: 'token',
              expiredDate: now,
            ),
          ),
        );
      });
    });

    group('Sad Path', () {
      test('로그인 실패 테스트', () async {
        final noAuthException = NoAuthorizedException();

        when(
          authRepository.login(
            email: '',
            password: '',
          ),
        ).thenAnswer((realInvocation) async {
          return Left(LoginFailure(
            code: noAuthException.code,
            exception: noAuthException,
            message: noAuthException.message,
            retryable: true,
          ));
        });

        final auth = await loginController.login(
            loginInfo: LoginInfo(email: '', password: ''));

        final failure = auth.fold(
          (failure) => failure,
          (user) => user,
        );

        expect(failure is LoginFailure, isTrue);

        expect(
          (failure as LoginFailure).code,
          noAuthException.code,
        );
      });
    });
  });
}
