import 'package:aab_crypto_app/core/constants/app_constants.dart';
import 'package:aab_crypto_app/features/home/view/home_screen.dart';
import 'package:aab_crypto_app/features/main/view/log_in_modal.dart';
import 'package:aab_crypto_app/features/main/view_model/main_controller.dart';
import 'package:aab_crypto_app/features/trade/view/trade_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  final MainController controller = Get.put(MainController());

  MainScreen({super.key}) {
    controller.loadLoginState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: AppConstants.initialTabIndex,
      length: AppConstants.tabsCount,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppConstants.title),
          backgroundColor: AppConstants.primaryColor,
          toolbarHeight: AppConstants.toolBarHeight,
          bottom: const TabBar(
            indicatorColor: AppConstants.secondaryColor,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: AppConstants.indicatorWeight,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.home, color: AppConstants.secondaryColor)),
              Tab(
                  icon: Icon(Icons.attach_money_sharp,
                      color: AppConstants.secondaryColor))
            ],
          ),
          actions: [
            Obx(() {
              return IconButton(
                icon: Icon(
                    controller.isLoggedIn.value ? Icons.logout : Icons.login),
                onPressed: () {
                  if (controller.isLoggedIn.value) {
                    controller.logout();
                  } else {
                    _showLoginModal(context);
                  }
                },
              );
            })
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            HomeScreen(),
            TradeScreen(),
          ],
        ),
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
