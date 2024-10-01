import 'package:aab_crypto_app/core/constants/app_constants.dart';
import 'package:aab_crypto_app/core/localizations/app_strings.dart';
import 'package:aab_crypto_app/features/home/models/asset_model.dart';
import 'package:aab_crypto_app/features/home/services/home_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var assets = <AssetModel>[].obs;
  var displayAssets = <AssetModel>[].obs;
  var displaySize = AppConstants.ten;
  var iconUrls = <String, String>{}.obs;
  var sortingCriteria = AppStrings.empty.obs;
  var isLoading = false.obs;

  final HomeService homeService;

  HomeController(this.homeService);

  @override
  void onInit() {
    super.onInit();
    fetch();
  }

  Future<void> fetch() async {
    if (isLoading.value) return;
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
    if (sortingCriteria.value == AppStrings.name) {
      assets.sort((a, b) => (a.name.trim()).compareTo((b.name.trim())));
    } else if (sortingCriteria.value == AppStrings.price) {
      assets.sort((a, b) => (b.price!).compareTo(a.price!));
    } else if (sortingCriteria.value == AppStrings.nameReversed) {
      assets.sort((a, b) => (b.name.trim()).compareTo((a.name.trim())));
    } else if (sortingCriteria.value == AppStrings.priceReversed) {
      assets.sort((a, b) => (a.price!).compareTo(b.price!));
    }
    displayAssets.clear();
    displayAssets.value = assets.take(displaySize).toList();
  }

  Future<void> fetchAssets() async {
    isLoading.value = true;
    final allAssets = await homeService.fetchAssets();
    List<AssetModel> filteredAssets = [];
    for (var asset in allAssets) {
      if (asset.isCrypto && asset.price != null) filteredAssets.add(asset);
    }
    assets.assignAll(filteredAssets);
    displayAssets.assignAll(assets.take(displaySize));
    isLoading.value = false;
  }

  Future<void> fetchIcons() async {
    final allIcons = await homeService.fetchIcons();
    if (allIcons.isNotEmpty) {
      iconUrls.value = allIcons;
    }
  }
}
