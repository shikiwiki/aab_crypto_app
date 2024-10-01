import 'package:aab_crypto_app/core/di/dependency_injection.dart';
import 'package:aab_crypto_app/features/main/view/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  await GetStorage.init();
  setupDi();
  runApp(const CryptoApp());
}

class CryptoApp extends StatelessWidget {
  const CryptoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      routes: {'/main': (context) => const MainScreen()},
      home: const MainScreen(),
    );
  }
}
