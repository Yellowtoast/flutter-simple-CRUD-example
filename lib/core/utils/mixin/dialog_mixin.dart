import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 앱에서 계속 사용되는 dialog에 대한 mixin
mixin DialogMixin {
  Future<bool?> showTwoButtonDialog(
      {required String titleText,
      String? subtitleText,
      required String cancleText,
      required String confirmText}) async {
    return await Get.dialog<bool>(AlertDialog(
      title: Column(
        children: [
          Text(
            titleText,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Text(subtitleText ?? ''),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Get.back(result: false),
          child: Text(
            cancleText,
          ),
        ),
        ElevatedButton(
          onPressed: () => Get.back(result: true),
          child: Text(
            confirmText,
          ),
        ),
      ],
    ));
  }

  showOneButtonDialog(
      {required String titleText,
      required String buttonText,
      required bool barrierDismissible,
      void Function()? onTapButton}) async {
    Get.dialog<bool>(
      AlertDialog(
        title: Text(titleText),
        actions: [
          ElevatedButton(
            onPressed: onTapButton,
            child: Text(
              buttonText,
            ),
          ),
        ],
      ),
      barrierDismissible: barrierDismissible,
    );
  }
}
