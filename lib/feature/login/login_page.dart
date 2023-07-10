import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_test/feature/login/controller/login_controller.dart';
import 'package:tech_test/feature/login/widgets/login_button.dart';
import 'package:tech_test/feature/login/widgets/login_text_form_field.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('로그인'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 24),
              const FlutterLogo(size: 48),
              const SizedBox(height: 16),
              LoginTextFormField(
                key: const Key('emailTextField'),
                onTapClear: controller.onEmailClear,
                onTextChanged: controller.onEmailChanged,
                textEditingController: controller.emailTextController,
                label: 'Email',
                maxLength: 20,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 16),
              LoginTextFormField(
                key: const Key('passwordTextField'),
                textEditingController: controller.passwordController,
                onTextChanged: controller.onPasswordChanged,
                textInputAction: TextInputAction.done,
                maxLength: 15,
                obscureText: true,
                label: 'Password',
                onTapClear: controller.onPasswordClear,
              ),
              const SizedBox(height: 16),
              Obx(
                () => LoginButton(
                  key: const Key('loginButton'),
                  active: controller.isButtonValid.value,
                  onTapButton: () => controller.onTapLoginButton(
                    loginInfo: controller.loginInfo.value,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
