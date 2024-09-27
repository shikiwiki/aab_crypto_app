import 'package:aab_crypto_app/features/home/view/home_screen.dart';
import 'package:aab_crypto_app/features/main/services/main_service.dart';
import 'package:aab_crypto_app/features/main/view_model/main_controller.dart';
import 'package:aab_crypto_app/features/trade/view/trade_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  final MainController controller = Get.put(MainController(MainServiceImpl()));

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sticky Header with Nav'),
        actions: [
          Obx(() {
            if (!controller.isLoggedIn.value) {
              return IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  controller.toggleLogin(); // For demo purposes, toggle login state
                  Get.snackbar('Login', 'User Logged In');
                },
              );
            }
            return const SizedBox.shrink(); // Return empty widget if logged in
          })
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey[300],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(onPressed: () => Get.to(HomeScreen()), child: const Text('Home')),
                TextButton(onPressed: () => Get.to(const TradeScreen()), child: const Text('Trade')),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.label),
                    title: Text('Item $index'),
                    subtitle: Text('Details about item $index'),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}