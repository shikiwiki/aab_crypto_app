import 'package:aab_crypto_app/features/main/view_model/models/item.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var items = <Item>[].obs;
  var page = 1.obs;
  var sortBy = 'name'.obs;
  var isLoading = false.obs;

  final Dio _dio = Dio(); // Create Dio instance

  @override
  void onInit() {
    super.onInit();
    fetchItems();
  }

  Future<void> fetchItems() async {
    if (isLoading.value) return; // Prevent multiple requests
    isLoading.value = true;

    try {
      final response =
          await _dio.get('https://api.example.com/items', queryParameters: {
        'page': page.value,
        'sort': sortBy.value,
      });

      if (response.statusCode == 200) {
        List<Item> newItems =
            (response.data as List).map((data) => Item.fromJson(data)).toList();
        items.addAll(newItems);
      } else {
        throw Exception('Failed to load items');
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void loadMoreItems() {
    page.value++;
    fetchItems();
  }

  void changeSort(String? value) {
    if (value != null) {
      sortBy.value = value;
      items.clear();
      page.value = 1; // Reset to first page
      fetchItems();
    }
  }
}
