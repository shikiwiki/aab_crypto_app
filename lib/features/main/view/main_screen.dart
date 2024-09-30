import 'package:aab_crypto_app/core/constants/app_constants.dart';
import 'package:aab_crypto_app/core/localizations/app_strings.dart';
import 'package:aab_crypto_app/core/ui_kit/colors/app_colors.dart';
import 'package:aab_crypto_app/features/home/view/home_screen.dart';
import 'package:aab_crypto_app/features/main/view/log_in_modal.dart';
import 'package:aab_crypto_app/features/main/view_model/main_controller.dart';
import 'package:aab_crypto_app/features/trade/view/trade_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController controller = Get.find<MainController>();

    return DefaultTabController(
      length: AppConstants.tabsCount,
      child: Scaffold(
        appBar: AppBar(
          title: Obx(() {
            return Text(
              controller.isLoggedIn.value
                  ? controller.userEmail.value
                  : AppStrings.title,
            );
          }),
          foregroundColor: AppColors.secondaryColor,
          backgroundColor: AppColors.primaryColor,
          toolbarHeight: AppConstants.toolBarHeight,
          bottom: const TabBar(
            indicatorColor: AppColors.secondaryColor,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: AppConstants.indicatorWeight,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.home, color: AppColors.secondaryColor)),
              Tab(
                  icon: Icon(Icons.attach_money_sharp,
                      color: AppColors.secondaryColor))
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
        body: const TabBarView(
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
        return const LogInModal();
      },
    );
  }
}
