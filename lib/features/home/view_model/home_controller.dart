import 'package:aab_crypto_app/core/constants/app_constants.dart';
import 'package:aab_crypto_app/features/home/view_model/models/asset.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var assets = <Asset>[].obs;
  var displayAssets = <Asset>[].obs;
  var displaySize = AppConstants.ten;
  var iconUrls = <String, String>{}.obs;
  var sortingCriteria = AppConstants.empty.obs;
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
    fetchIcons();
    fetchAssets();
  }

  void showMoreItems() {
    if (displayAssets.length < assets.length) {
      final nextItems =
          assets.skip(displayAssets.length).take(displaySize).toList();
      displayAssets.addAll(nextItems);
    }
  }

  void sortByCriteria() {
    if (sortingCriteria.value == AppConstants.name) {
      assets.sort((a, b) => (a.name.trim()).compareTo((b.name.trim())));
    } else if (sortingCriteria.value == AppConstants.price) {
      assets.sort((a, b) => (b.price!).compareTo(a.price!));
    } else if (sortingCriteria.value == AppConstants.nameReversed) {
      assets.sort((a, b) => (b.name.trim()).compareTo((a.name.trim())));
    } else if (sortingCriteria.value == AppConstants.priceReversed) {
      assets.sort((a, b) => (a.price!).compareTo(b.price!));
    }
    displayAssets.clear();
    displayAssets.value = assets.take(displaySize).toList();
  }

  Future<void> fetchAssets() async {
    try {
      final response = await dio.get('${AppConstants.baseUrl}/v1/assets');

      if (response.statusCode == 200) {
        List<Asset> allAssets =
        (response.data as List).map((json) => Asset.fromJson(json)).toList();
        List<Asset> cryptoItems = [];
        for (var asset in allAssets) {
          if (asset.isCrypto && asset.price != null) cryptoItems.add(asset);
        }
        assets.assignAll(cryptoItems);
        displayAssets.assignAll(assets.take(displaySize));
      } else {
        throw Exception('Failed to load assets');
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchIcons() async {
    try {
      final response =
          await dio.get('${AppConstants.baseUrl}/v1/assets/icons/16');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        for (var asset in data) {
          if (asset['asset_id'] != null && asset['url'] != null) {
            iconUrls[asset['asset_id']] = asset['url'];
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
