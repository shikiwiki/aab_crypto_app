import 'package:aab_crypto_app/core/api/api_provider.dart';
import 'package:aab_crypto_app/core/constants/app_constants.dart';
import 'package:aab_crypto_app/features/home/view_model/models/asset.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var assets = <Asset>[].obs;
  var displayAssets = <Asset>[].obs;
  var displaySize = AppConstants.ten;
  var iconUrls = <String, String>{}.obs;
  var sortingCriteria = AppConstants.empty.obs;
  var isLoading = false.obs;
  final ApiProvider apiProvider = Get.put(ApiProvider());

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
      final response =
          await apiProvider.getDio().get(AppConstants.assetsEndpoint);

      if (response.statusCode == AppConstants.codeOk) {
        List<Asset> allAssets = (response.data as List)
            .map((json) => Asset.fromJson(json))
            .toList();
        List<Asset> filteredItems = [];
        for (var asset in allAssets) {
          if (asset.isCrypto && asset.price != null) filteredItems.add(asset);
        }
        assets.assignAll(filteredItems);
        displayAssets.assignAll(assets.take(displaySize));
      } else {
        throw Exception(AppConstants.fetchAssetsExceptionMessage);
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
          await apiProvider.getDio().get(AppConstants.iconsEndpoint);

      if (response.statusCode == AppConstants.codeOk) {
        final List<dynamic> data = response.data;
        for (var asset in data) {
          if (asset[AppConstants.assetId] != null && asset[AppConstants.url] != null) {
            iconUrls[asset[AppConstants.assetId]] = asset[AppConstants.url];
          }
        }
      } else {
        throw Exception(AppConstants.fetchIconsExceptionMessage);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}