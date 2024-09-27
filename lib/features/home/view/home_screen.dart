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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            DropdownButton<String>(
              value: controller.sortBy.value,
              items: <String>['name', 'price'].map((String value) {
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
              return const Center(child: Text('No items found'));
            }
            return ListView.builder(
              itemCount: controller.items.length + 1,
              // +1 for the load more button
              itemBuilder: (context, index) {
                if (index < controller.items.length) {
                  return ListTile(
                    leading: const Icon(Icons.label),
                    title: Text(controller.items[index].name),
                    subtitle: Text('\$${controller.items[index].price}'),
                  );
                } else if (!controller.isLoading.value) {
                  return TextButton(
                    onPressed: controller.loadMoreItems,
                    child: const Text('Load More'),
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
