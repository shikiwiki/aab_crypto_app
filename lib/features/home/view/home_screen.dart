import 'package:aab_crypto_app/core/constants/app_constants.dart';
import 'package:aab_crypto_app/core/widgets/item_widget.dart';
import 'package:aab_crypto_app/features/home/view_model/home_controller.dart';
import 'package:aab_crypto_app/features/main/view_model/models/item.dart';
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
              value: controller.sortBy.value,
              items: <String>[AppConstants.name, AppConstants.price]
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value.capitalizeFirst!),
                );
              }).toList(),
              onChanged: controller.changeSort,
            ),
          ],
        ),
        Expanded(
          child: Obx(() {
            if (controller.items.isEmpty && !controller.isLoading.value) {
              return const Center(child: Text(AppConstants.noItemsFound));
            }
            return ListView.builder(
              itemCount: controller.items.length + AppConstants.one,
              // +1 for the load more button
              itemBuilder: (context, index) {
                if (index < controller.items.length) {
                  return ItemWidget(item: Item.empty());
                } else if (!controller.isLoading.value) {
                  return TextButton(
                    onPressed: controller.loadMoreItems,
                    child: const Text(AppConstants.more),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            );
          }),
        ),
      ],
    );
  }
}
