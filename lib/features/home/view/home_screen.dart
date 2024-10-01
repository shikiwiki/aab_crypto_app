import 'package:aab_crypto_app/core/constants/app_constants.dart';
import 'package:aab_crypto_app/core/localizations/app_strings.dart';
import 'package:aab_crypto_app/features/home/view/widgets/asset_widget.dart';
import 'package:aab_crypto_app/features/home/view_model/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSortDropdown(homeController),
        Expanded(
          child: Obx(() => _buildAssetList(homeController)),
        ),
      ],
    );
  }

  _buildSortDropdown(HomeController homeController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        DropdownButton<String>(
          hint: const Text(AppStrings.sortBy),
          items:
              <String>[AppStrings.name, AppStrings.price].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              final newCriteria = homeController.sortingCriteria.value == value
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
    );
  }

  _buildAssetList(HomeController homeController) {
    if (homeController.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }
    if (homeController.assets.isEmpty) {
      return const Center(child: Text(AppStrings.noItemsFound));
    }
    return RefreshIndicator(
      onRefresh: homeController.fetchAssets,
      child: ListView.builder(
        itemCount: homeController.displayAssets.length + AppConstants.one,
        itemBuilder: (context, index) {
          if (index < homeController.displayAssets.length) {
            final asset = homeController.displayAssets[index];

            return AssetWidget(
              key: ValueKey(asset.assetId),
              asset: asset,
              iconUrl: homeController.iconUrls[asset.assetId],
            );
          } else {
            return _buildMoreButton(homeController);
          }
        },
      ),
    );
  }

  _buildMoreButton(HomeController homeController) {
    return TextButton(
      onPressed: homeController.showMoreItems,
      child: const Text(AppStrings.more),
    );
  }
}
