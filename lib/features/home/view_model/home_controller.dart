import 'package:aab_crypto_app/core/constants/app_constants.dart';
import 'package:aab_crypto_app/features/home/view_model/models/item.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var items = <Item>[].obs;
  var displayItems = <Item>[].obs;
  var displaySize = 10;
  var sortingCriteria = ''.obs;
  var isLoading = false.obs;

  final Dio dio = Dio();

  @override
  void onInit() {
    super.onInit();
    fetchItems();
  }

  Future<void> fetchItems() async {
    if (isLoading.value) return;
    isLoading.value = true;

    dio.options.headers['Content-Type'] = AppConstants.contentType;
    dio.options.headers['X-CoinAPI-Key'] = AppConstants.apiKey;

    try {
      final response = await dio.get(
        '${AppConstants.baseUrl}/v1/assets',
        // queryParameters: {
        //   'limit': showAmount.value,
        //   'offset': offset.value,
        // },
      );

      if (response.statusCode == 200) {
        List<Item> newItems =
            (response.data as List).map((json) => Item.fromJson(json)).toList();
        items.assignAll(newItems);
        displayItems.assignAll(
            items.take(displaySize)); // Show the first pageSize items initially
        debugPrint('ITEMS_LIST contains ${items.length} items:\n');
      } else {
        throw Exception('Failed to load items');
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void showMoreItems() {
    if (displayItems.length < items.length) {
      final nextItems =
          items.skip(displayItems.length).take(displaySize).toList();
      displayItems.addAll(nextItems);
    }
    // showAmount.value+10;
    // offset.value+10;
    // fetchItems();
  }

  void sortByCriteria() {
    if (sortingCriteria.value == AppConstants.name) {
      items.sort((a, b) => a.name.compareTo(b.name));
    } else if (sortingCriteria.value == AppConstants.price) {
      items.sort((a, b) {
        final priceA = double.tryParse(a.price ?? '') ?? 0;
        final priceB = double.tryParse(b.price ?? '') ?? 0;
        return priceA.compareTo(priceB); // Sort by price
      });
    }
    displayItems.assignAll(items.take(displaySize));
  }
}
