import 'package:get/get.dart';
import 'package:tech_test/core/utils/mixin/snackbar_mixin.dart';
import 'package:tech_test/data/model/user.dart';
import 'package:tech_test/data/repository/auth_repository.dart';
import 'package:tech_test/data/repository/local_repository.dart';
import 'package:tech_test/core/utils/mixin/dialog_mixin.dart';
import 'package:tech_test/core/utils/mixin/loading_mixin.dart';
import 'package:tech_test/routes/app_routes.dart';

abstract class ProfilePageController {
  final email = ''.obs;
  Future<void> logout();
}

class ProfilePageControllerImpl extends GetxController
    with DialogMixin, LoadingMixin, SnackbarMixin
    implements ProfilePageController {
  ProfilePageControllerImpl(
      {required AuthRepository authRepository,
      required LocalRepository localRepository})
      : _authRepository = authRepository,
        _localRepository = localRepository;

  final AuthRepository _authRepository;

  final LocalRepository _localRepository;

  @override
  final email = ''.obs;

  @override
  onReady() {
    super.onReady();
    // 로컬에 저장된 유저 정보를 불러옵니다.
    final User? user = _localRepository.getUser();
    _handleUserInfo(user);
  }

  _handleUserInfo(User? user) async {
    if (user == null) {
      showOneButtonDialog(
        titleText: '유저정보를 불러올 수 없습니다.\n다시 로그인해주세요.',
        buttonText: '로그인하기',
        barrierDismissible: false,
        onTapButton: () => Get.offAllNamed(Routes.login),
      );
    } else {
      _setUserInfo(user);
    }
  }

  _setUserInfo(User user) {
    email.value = user.email;
  }

  @override
  Future<void> logout() async {
    final logoutEither = await showDataLoadingOverlay(
        asyncFunction: () => _authRepository.logout());

    logoutEither.fold(
      (failure) => showSnackbar(
        message: failure.message,
      ),
      (succeed) => _localRepository.clearUser().then(
            (value) => Get.offAllNamed(Routes.login),
          ),
    );
  }
}
