import 'package:aab_crypto_app/core/localizations/app_strings.dart';
import 'package:aab_crypto_app/features/main/view_model/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInModal extends StatefulWidget {
  const LogInModal({super.key});

  @override
  State<LogInModal> createState() => _LogInModalState();
}

class _LogInModalState extends State<LogInModal> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final MainController mainController = Get.find<MainController>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(AppStrings.logIn),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: AppStrings.email),
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(labelText: AppStrings.password),
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
              // Call the login method and pass the email and password
              mainController.login(
                  emailController.text, passwordController.text);
              Get.back();
              Get.snackbar(AppStrings.logIn, AppStrings.logInMessage);
            } else {
              Get.snackbar(AppStrings.error, AppStrings.errorMessage);
            }
          },
          child: const Text(AppStrings.logIn),
        ),
      ],
    );
  }
}
