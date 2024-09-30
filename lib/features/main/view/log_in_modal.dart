import 'package:aab_crypto_app/core/constants/app_constants.dart';
import 'package:aab_crypto_app/features/main/view_model/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInModal extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final MainController mainController = Get.find<MainController>();

  LogInModal({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(AppConstants.logIn),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: AppConstants.email),
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(labelText: AppConstants.password),
            obscureText: true,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            final RegExp emailRegExp = RegExp(
              r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
            );
            final RegExp passwordRegExp = RegExp(r'^[A-Za-z0-9.]+$');
            if (emailRegExp.hasMatch(emailController.text) &&
                passwordRegExp.hasMatch(passwordController.text)) {
              mainController.toggleLogin();
              Get.back();
              Get.snackbar(AppConstants.logIn, AppConstants.logInMessage);
            } else {
              Get.snackbar(AppConstants.error, AppConstants.errorMessage);
            }
          },
          child: const Text(AppConstants.logIn),
        ),
      ],
    );
  }
}
