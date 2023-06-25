import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_test/feature/login/controller/login_controller.dart';

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
              TextFormField(
                key: const Key('emailTextField'),
                controller: controller.emailController,
                onChanged: controller.onEmailChanged,
                textInputAction: TextInputAction.done,
                maxLength: 20,
                decoration: InputDecoration(
                  label: const Text('Email'),
                  counterText: '',
                  suffixIcon: InkWell(
                    onTap: () {},
                    child: const Icon(Icons.cancel),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                key: const Key('passwordTextField'),
                controller: controller.passwordController,
                onChanged: controller.onPasswordChanged,
                textInputAction: TextInputAction.done,
                maxLength: 15,
                obscureText: true,
                decoration: InputDecoration(
                  label: const Text('Password'),
                  counterText: '',
                  suffixIcon: InkWell(
                    onTap: () {},
                    child: const Icon(Icons.cancel),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // TODO: Email, Password 모두 작성 시에만 버튼 활성화.
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

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.active,
    required this.onTapButton,
  });

  final bool active;
  final void Function() onTapButton;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (active) ? onTapButton : null,
      child: const Text('Login'),
    );
  }
}
