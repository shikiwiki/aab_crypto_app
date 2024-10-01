import 'package:aab_crypto_app/core/constants/app_constants.dart';
import 'package:aab_crypto_app/core/localizations/app_strings.dart';
import 'package:aab_crypto_app/core/ui_kit/colors/app_colors.dart';
import 'package:aab_crypto_app/features/home/view/widgets/asset_widget.dart';
import 'package:aab_crypto_app/features/home/view_model/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State {
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DropdownButton(
              hint: const Text(AppStrings.sortBy),
              items: [AppStrings.name, AppStrings.price].map((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  final newCriteria =
                      homeController.sortingCriteria.value == value
                          ? '${value}Reversed'
                          : value;
                  if (homeController.sortingCriteria.value != newCriteria) {
                    homeController.sortingCriteria.value = newCriteria;
                    homeController.sortByCriteria();
                  }
                }
              },
            ),
          ],
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: homeController.fetchAssets,
            color: AppColors.primaryColor,
            child: Obx(() {
              if (homeController.errorMessage.value.isNotEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        homeController.errorMessage.value,
                        style: const TextStyle(color: AppColors.errorColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: AppConstants.separatorMedium),
                    ElevatedButton(
                      onPressed: homeController.fetch,
                      child: const Text(
                        AppStrings.tryAgain,
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ),
                  ],
                );
              }
              if (homeController.assets.isEmpty) {
                return const Center(child: Text(AppStrings.noItemsFound));
              }
              return ListView.builder(
                itemCount:
                    homeController.displayAssets.length + AppConstants.one,
                itemBuilder: (context, index) {
                  if (index < homeController.displayAssets.length) {
                    final asset = homeController.displayAssets[index];
                    return AssetWidget(
                      key: ValueKey(asset.assetId),
                      asset: asset,
                      iconUrl: homeController.iconUrls[asset.assetId],
                    );
                  } else {
                    return TextButton(
                      onPressed: homeController.showMoreItems,
                      child: const Text(AppStrings.more),
                    );
                  }
                },
              );
            }),
          ),
        ),
      ],
    );
  }
}
