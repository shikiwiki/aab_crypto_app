import 'package:aab_crypto_app/core/constants/app_constants.dart';
import 'package:aab_crypto_app/features/home/view/home_screen.dart';
import 'package:aab_crypto_app/features/main/services/main_service.dart';
import 'package:aab_crypto_app/features/main/view/log_in_modal.dart';
import 'package:aab_crypto_app/features/main/view_model/main_controller.dart';
import 'package:aab_crypto_app/features/trade/view/trade_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  final MainController controller = Get.put(MainController(MainServiceImpl()));

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.loadLoginState();

    return DefaultTabController(
      initialIndex: AppConstants.initialTabIndex,
      length: AppConstants.tabsCount,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppConstants.title),
          backgroundColor: Colors.yellow,
          toolbarHeight: AppConstants.toolBarHeight,
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.attach_money_sharp)),
            ],
          ),
          actions: [
            Obx(
              () {
                if (!controller.isLoggedIn.value) {
                  return IconButton(
                    icon: const Icon(Icons.login),
                    onPressed: () {
                      _showLoginModal(context);
                    },
                  );
                } else {
                  return IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: controller.logout,
                  );
                }
              },
            )
          ],
        ),
        body: Obx(() {
          return TabBarView(
            children: <Widget>[
              HomeScreen(),
              TradeScreen(),
            ],
          );
        }),
      ),
    );
  }

  void _showLoginModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LogInModal();
      },
    );
  }
}
