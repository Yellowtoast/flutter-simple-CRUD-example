import 'package:get/get.dart';
import 'package:tech_test/data/model/auth.dart';
import 'package:tech_test/data/repository/local_repository.dart';
import 'package:tech_test/routes/app_routes.dart';

abstract class SplashPageController {}

class SplashPageControllerImpl extends GetxController
    implements SplashPageController {
  SplashPageControllerImpl({required LocalRepository localRepository})
      : _localRepository = localRepository;

  final LocalRepository _localRepository;

  @override
  onReady() async {
    await Future.delayed(const Duration(seconds: 2));
    final auth = _localRepository.getAuthInfo();
    _handleRoutesByAuthInfo(auth);
  }

  /// 로컬에 저장된 auth정보를 통해 다음 페이지를 결정합니다
  _handleRoutesByAuthInfo(Authentication? auth) {
    if (auth == null) {
      Get.offAllNamed(Routes.login);
      return;
    }

    final bool isTokenValid = _checkTokenValid(auth);

    // 토큰 시간이 만료되었을 경우 로그인 화면으로 보냅니다.
    if (isTokenValid) {
      Get.offAllNamed(Routes.home);
    } else {
      Get.offAllNamed(Routes.login);
    }
  }

  /// 토큰의 시간이 만료되었는지 판단하는 함수
  bool _checkTokenValid(Authentication auth) {
    if (auth.expiredDate.isAfter(DateTime.now())) {
      return true;
    } else {
      return false;
    }
  }
}
