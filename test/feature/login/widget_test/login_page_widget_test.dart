// ignore_for_file: unnecessary_cast

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:tech_test/core/utils/pagination/pagination.dart';
import 'package:tech_test/data/model/auth.dart';
import 'package:tech_test/data/model/user.dart';
import 'package:tech_test/data/repository/auth_repository.dart';
import 'package:tech_test/data/repository/local_repository.dart';
import 'package:tech_test/data/repository/post_repository.dart';

import 'package:tech_test/feature/login/controller/login_controller.dart';
import 'package:tech_test/feature/login/login_page.dart';
import 'package:tech_test/routes/app_pages.dart';
import 'package:tech_test/routes/app_routes.dart';
import '../unit_test/login_controller_test.mocks.dart';

void main() {
  tearDown(Get.reset);

  final now = DateTime.now();

  final authRepository = MockAuthRepository();
  final localRepository = MockLocalRepository();
  final postRepository = MockPostRepository();

  setUp(() {
    Get.put(authRepository as AuthRepository);
    Get.put(localRepository as LocalRepository);
    Get.put(postRepository as PostRepository);
  });

  group('로그인 화면 위젯 테스트', () {
    group('Happy Path', () {
      testWidgets('각 필드에 입력 시 입력 여부 테스트', (WidgetTester tester) async {
        when(
          authRepository.login(
            email: 'example@example.com',
            password: 'password',
          ),
        ).thenAnswer((realInvocation) async {
          return Right(
            Authentication(expiredDate: DateTime.now(), token: 'token'),
          );
        });

        await tester.pumpWidget(
          LoginPageTestWidget(
            authRepository: authRepository,
            localRepository: localRepository,
          ),
        );

        await tester.pump(const Duration(seconds: 1));

        final emailTextFieldFinder = find.byKey(const Key('emailTextField'));
        final passwordTextFieldFinder =
            find.byKey(const Key('passwordTextField'));
        final loginButtonFinder = find.byKey(const Key('loginButton'));

        // 초기에는 로그인 버튼이 비활성화 된 상태이다
        expect(tester.widget<LoginButton>(loginButtonFinder).active, isFalse);

        // 이메일을 입력한다
        await tester.enterText(emailTextFieldFinder, 'example@example.com');
        await tester.pump();

        // 이메일만 입력했을 경우 로그인 버튼이 활성화 되지 않는다
        expect(tester.widget<LoginButton>(loginButtonFinder).active, isFalse);

        // 비밀번호를 입력한다
        await tester.enterText(passwordTextFieldFinder, 'password');
        await tester.pump();

        // 로그인 버튼이 활성화된다
        expect(tester.widget<LoginButton>(loginButtonFinder).active, isTrue);
      });
      // testWidgets('각 필드의 삭제 아이콘을 눌렀을 때, 삭제 여부 테스트', () {});

      testWidgets('Login 버튼을 눌렀을 때 로직 요청 테스트', (tester) async {
        when(
          authRepository.login(
            email: 'example@example.com',
            password: 'password',
          ),
        ).thenAnswer((realInvocation) async {
          return Right(
            Authentication(expiredDate: now, token: 'token'),
          );
        });

        when(
          localRepository.updateUser(User(
              auth: Authentication(expiredDate: now, token: 'token'),
              email: 'example@example.com')),
        ).thenAnswer((realInvocation) async {
          return true;
        });

        await tester.pumpWidget(
          LoginPageTestWidget(
            authRepository: authRepository,
            localRepository: localRepository,
          ),
        );

        final emailTextFieldFinder = find.byKey(const Key('emailTextField'));
        final passwordTextFieldFinder =
            find.byKey(const Key('passwordTextField'));
        final loginButtonFinder = find.byKey(const Key('loginButton'));

        // Enter valid email
        await tester.enterText(emailTextFieldFinder, 'example@example.com');
        await tester.enterText(passwordTextFieldFinder, 'password');
        await tester.pump();

        expect(tester.widget<LoginButton>(loginButtonFinder).active, isTrue);

        when(
          postRepository.getPosts(limit: 20, offset: 0),
        ).thenAnswer((realInvocation) async {
          return Right(PaginationError(message: '에러'));
        });

        await tester.tap(loginButtonFinder);
        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 10));

        expect(Get.currentRoute, Routes.home);
      });

      // testWidgets('올바른 로그인 요청일 때, 화면 이동 테스트', () {});
    });

    group('Sad Path', () {
      // testWidgets('로그인을 잘못 요청 했을 때 에러 처리 테스트', () {});
    });
  });
}

class LoginPageTestWidget extends StatelessWidget {
  const LoginPageTestWidget(
      {super.key, required this.authRepository, required this.localRepository});

  final AuthRepository authRepository;
  final LocalRepository localRepository;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: GetBuilder<LoginController>(
          init: LoginControllerImpl(
              authRepository: authRepository, localRepository: localRepository),
          builder: (controller) => const LoginPage()),
      getPages: AppPages.routes,
    );
  }
}
