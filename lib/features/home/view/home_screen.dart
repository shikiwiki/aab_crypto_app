import 'package:aab_crypto_app/core/constants/app_constants.dart';
import 'package:aab_crypto_app/core/localizations/app_strings.dart';
import 'package:aab_crypto_app/core/ui_kit/widgets/asset_widget.dart';
import 'package:aab_crypto_app/features/home/view_model/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DropdownButton<String>(
              hint: const Text(AppStrings.sortBy),
              items: <String>[AppStrings.name, AppStrings.price]
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  controller.sortingCriteria.value =
                      controller.sortingCriteria.value == value
                          ? '${value}Reversed'
                          : value;
                  controller.sortByCriteria();
                }
              },
            ),
          ],
        ),
        Expanded(
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.assets.isEmpty) {
              return const Center(child: Text(AppStrings.noItemsFound));
            }
            return RefreshIndicator(
              onRefresh: controller.fetchAssets,
              child: ListView.builder(
                itemCount: controller.displayAssets.length + AppConstants.one,
                itemBuilder: (context, index) {
                  if (index < controller.displayAssets.length) {
                    final asset = controller.displayAssets[index];

                    return AssetWidget(
                      key: ValueKey(asset.assetId), // Using ValueKey for unique identification
                      asset: asset,
                      iconUrl: controller.iconUrls[asset.assetId],
                    );
                  } else {
                    return TextButton(
                      onPressed: controller.showMoreItems,
                      child: const Text(AppStrings.more),
                    );
                  }
                },
              ),
            );
          }),
        ),
      ],
    );
  }
}