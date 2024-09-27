import 'package:aab_crypto_app/features/main/view_model/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInModal extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final MainController mainController = Get.find();

  LogInModal({super.key});
// //узнавать, авторизован ли - в гет сторадж

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Login'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Simulate a login, replace with actual authentication logic
            if (emailController.text.isNotEmpty &&
                passwordController.text.isNotEmpty) {
              mainController.toggleLogin(); // Login state toggled
              Get.back(); // Close the modal
            } else {
              Get.snackbar('Error', 'Please enter both email and password');
            }
          },
          child: const Text('Login'),
        ),
      ],
    );
  }
}