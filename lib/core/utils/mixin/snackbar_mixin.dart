import 'package:get/get.dart';

/// 앱에서 계속 사용되는 snackbar에 대한 mixin
mixin SnackbarMixin {
  showSnackbar({required String message}) {
    Get.showSnackbar(GetSnackBar(
      message: message,
    ));
  }
}
