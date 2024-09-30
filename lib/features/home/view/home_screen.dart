import 'package:aab_crypto_app/core/constants/app_constants.dart';
import 'package:aab_crypto_app/core/widgets/asset_widget.dart';
import 'package:aab_crypto_app/features/home/view_model/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DropdownButton<String>(
              hint: const Text(AppConstants.sortBy),
              items: <String>[AppConstants.name, AppConstants.price]
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
              return const Center(child: Text(AppConstants.noItemsFound));
            }
            return RefreshIndicator(
              onRefresh: controller.fetchAssets,
              child: ListView.builder(
                itemCount: controller.displayAssets.length + AppConstants.one,
                itemBuilder: (context, index) {
                  if (index < controller.displayAssets.length) {
                    return AssetWidget(
                      asset: controller.displayAssets[index],
                      iconUrl: controller
                          .iconUrls[controller.displayAssets[index].assetId],
                    );
                  } else {
                    return TextButton(
                      onPressed: controller.showMoreItems,
                      child: const Text(AppConstants.more),
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
