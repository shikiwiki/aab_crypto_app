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
              onChanged: (_) {
                controller.sortByCriteria();
              },
            ),
          ],
        ),
        Expanded(
          child: Obx(() {
            if (controller.assets.isEmpty && !controller.isLoading.value) {
              return const Center(child: Text(AppConstants.noItemsFound));
            }
            return RefreshIndicator(
              onRefresh: () async {
                await controller.fetch();
              },
              child: ListView.builder(
                itemCount: controller.displayAssets.length + AppConstants.one,
                itemBuilder: (context, index) {
                  if (index < controller.displayAssets.length) {
                    return AssetWidget(
                      asset: controller.assets[index],
                      iconUrl: controller.iconUrls[controller.assets[index].assetId],
                    );
                  } else if (!controller.isLoading.value) {
                    return TextButton(
                      onPressed: controller.showMoreItems,
                      child: const Text(AppConstants.more),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
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
