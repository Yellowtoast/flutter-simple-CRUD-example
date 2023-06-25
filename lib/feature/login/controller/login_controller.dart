import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_test/core/utils/failure/failure.dart';
import 'package:tech_test/core/utils/mixin/snackbar_mixin.dart';
import 'package:tech_test/data/model/auth.dart';
import 'package:tech_test/data/model/user.dart';
import 'package:tech_test/data/repository/auth_repository.dart';
import 'package:tech_test/data/repository/local_repository.dart';
import 'package:tech_test/core/utils/mixin/loading_mixin.dart';
import 'package:tech_test/routes/app_routes.dart';

///
/// [AuthRepository]를 인자로 가진다
/// 구현 요구사항
/// - 로그인을 요청하는 함수
/// - 로그아웃을 요청하는 함수
abstract class LoginController extends GetxController {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final loginInfo = LoginInfo(email: '', password: '').obs;

  final isButtonValid = false.obs;

  onEmailChanged(String email);

  onPasswordChanged(String pwd);

  onEmailClear();

  onPasswordClear();

  Future<void> onTapLoginButton({required LoginInfo loginInfo});

  Future<Either<Failure, User>> login({required LoginInfo loginInfo});

  LoginController(
      {required AuthRepository authRepository,
      required LocalRepository localRepository});
}

class LoginInfo {
  String email;
  String password;
  LoginInfo({required this.email, required this.password});
}

class LoginControllerImpl extends GetxController
    with LoadingMixin, SnackbarMixin
    implements LoginController {
  LoginControllerImpl(
      {required AuthRepository authRepository,
      required LocalRepository localRepository})
      : _authRepository = authRepository,
        _localRepository = localRepository;

  final AuthRepository _authRepository;

  final LocalRepository _localRepository;

  @override
  final emailController = TextEditingController();

  @override
  final passwordController = TextEditingController();

  @override
  final loginInfo = LoginInfo(email: '', password: '').obs;

  @override
  final isButtonValid = false.obs;

  @override
  onReady() {
    super.onReady();
    ever(loginInfo, _validateLoginButton);
  }

  @override
  onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  @override
  onEmailChanged(String email) {
    loginInfo.update((val) {
      val?.email = email;
    });
  }

  @override
  onPasswordChanged(String pwd) {
    loginInfo.update((val) {
      val?.password = pwd;
    });
  }

  @override
  onEmailClear() {
    emailController.clear();
    onEmailChanged('');
  }

  @override
  onPasswordClear() {
    passwordController.clear();
    onPasswordChanged('');
  }

  @override
  onTapLoginButton({required LoginInfo loginInfo}) async {
    final loginEither = await showDataLoadingOverlay(
        asyncFunction: () => login(loginInfo: loginInfo));

    loginEither.fold(
      (failure) => showSnackbar(message: failure.message),
      (user) async {
        // 로그인에 성공하면, 유저 및 토큰 정보를 로컬에 저장합니다
        final succeed = await _updateUserInfoLocal(
          authResult: user.auth,
          email: user.email,
        );

        if (succeed) {
          Get.offAllNamed(Routes.home);
        } else {
          showSnackbar(message: '유저 정보를 로컬에 저장하지 못했습니다.');
        }
      },
    );
  }

  @override
  Future<Either<Failure, User>> login({required LoginInfo loginInfo}) async {
    final authEither = await _authRepository.login(
      email: loginInfo.email,
      password: loginInfo.password,
    );
    return authEither.fold(
      (failure) => Left(failure),
      (auth) => Right(
        User(
          email: loginInfo.email,
          auth: auth,
        ),
      ),
    );
  }

  _validateLoginButton(LoginInfo newLoginInfo) {
    if (newLoginInfo.email.isNotEmpty && newLoginInfo.password.isNotEmpty) {
      isButtonValid.value = true;
    } else {
      isButtonValid.value = false;
    }
  }

  /// 유저 및 토큰 정보를 로컬에 저장합니다
  _updateUserInfoLocal(
      {required Authentication authResult, required String email}) async {
    final updateSucceed =
        await _localRepository.updateUser(User(email: email, auth: authResult));

    return updateSucceed;
  }
}
