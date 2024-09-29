import 'package:aab_crypto_app/core/constants/app_constants.dart';
import 'package:aab_crypto_app/features/home/view_model/models/item.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var items = <Item>[].obs;
  var displayItems = <Item>[].obs;
  var displaySize = AppConstants.ten;
  var iconUrls = <String, String>{}.obs;
  var sortingCriteria = AppConstants.name.obs;
  var isLoading = false.obs;

  final Dio dio = Dio()
    ..options.headers['Content-Type'] = AppConstants.contentType
    ..options.headers['X-CoinAPI-Key'] = AppConstants.apiKey;

  @override
  void onInit() {
    super.onInit();
    fetch();
  }

  Future<void> fetch() async {
    if (isLoading.value) return;
    isLoading.value = true;
    fetchAllIcons();
    fetchItems();
  }

  void showMoreItems() {
    if (displayItems.length < items.length) {
      final nextItems =
          items.skip(displayItems.length).take(displaySize).toList();
      displayItems.addAll(nextItems);
    }
  }

  void sortByCriteria() {
    if (sortingCriteria.value == AppConstants.name) {
      items.sort((a, b) => a.name.compareTo(b.name));
    } else if (sortingCriteria.value == AppConstants.price) {
      items.sort((a, b) => (b.price ?? AppConstants.zero)
          .compareTo(a.price ?? AppConstants.zero));
    }
    displayItems.clear();
    displayItems.value = items.take(displaySize).toList();
    // displayItems.assignAll(items.take(displaySize));
  }

  Future<void> fetchItems() async {
    try {
      final response = await dio.get('${AppConstants.baseUrl}/v1/assets');

      if (response.statusCode == 200) {
        List<Item> allItems =
            (response.data as List).map((json) => Item.fromJson(json)).toList();
        List<Item> cryptoItems = [];
        for (var item in allItems) {
          if (item.isCrypto) cryptoItems.add(item);
        }
        items.assignAll(cryptoItems);
        displayItems.assignAll(items.take(displaySize));
      } else {
        throw Exception('Failed to load items');
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAllIcons() async {
    try {
      final response =
          await dio.get('${AppConstants.baseUrl}/v1/assets/icons/16');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        for (var item in data) {
          if (item['asset_id'] != null && item['url'] != null) {
            iconUrls[item['asset_id']] = item['url'];
          }
        }
      } else {
        debugPrint('Failed to load icon urls');
      }
    } catch (e) {
      debugPrint('Error fetching icon urls: $e');
    }
  }
}
