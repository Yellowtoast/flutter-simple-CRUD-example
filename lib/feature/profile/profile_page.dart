import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_test/feature/profile/widgets/logout_button.dart';
import 'package:tech_test/feature/profile/widgets/profile_info_container.dart';
import 'profile_page_controller.dart';

class ProfilePage extends GetView<ProfilePageController> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfilePage'),
        actions: [
          LogoutButton(
            onTapLogout: controller.logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Obx(
          () => Center(
            child: Column(
              children: [
                const SizedBox(height: 30),
                ProfileInfoContainer(
                  email: controller.email.value,
                  name: '김더즌',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
