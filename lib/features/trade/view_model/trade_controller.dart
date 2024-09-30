import 'package:aab_crypto_app/core/api/api_provider.dart';
import 'package:aab_crypto_app/core/constants/app_constants.dart';
import 'package:aab_crypto_app/features/home/view_model/models/asset.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class TradeController extends GetxController {
  var fiatAmount = AppConstants.zero.obs;
  var currentAsset = Asset.empty().obs;
  var cryptoAssets = <Asset>[].obs;
  num cryptoAmount = AppConstants.zero;
  final ApiProvider apiProvider = Get.put(ApiProvider());

  @override
  void onInit() {
    super.onInit();
    fetchAssets();
  }

  void selectItem(String name) {
    final selectedItem = cryptoAssets.firstWhere(
      (asset) => asset.name == name,
      orElse: () => Asset.empty(),
    );
    currentAsset.value = selectedItem;
    calculateFiatAmount();
  }

  Future<void> fetchAssets() async {
    try {
      final response =
          await apiProvider.getDio().get(AppConstants.assetsEndpoint);

      if (response.statusCode == AppConstants.codeOk) {
        List<Asset> allAssets = (response.data as List)
            .map((json) => Asset.fromJson(json))
            .toList();
        for (var asset in allAssets) {
          if (asset.isCrypto && asset.price != null) cryptoAssets.add(asset);
        }
      } else {
        throw Exception(AppConstants.fetchAssetsExceptionMessage);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    if (cryptoAssets.isNotEmpty) {
      currentAsset.value = cryptoAssets.first;
    }
  }

  void calculateFiatAmount() {
    if (currentAsset.value.price != null) {
      fiatAmount.value = cryptoAmount * currentAsset.value.price!;
    }
  }

  void swapFields() {
    if (currentAsset.value.price != null && currentAsset.value.price! > AppConstants.zero) {
      if (fiatAmount.value > AppConstants.zero) {
        cryptoAmount =
            num.tryParse(fiatAmount.value.toStringAsFixed(AppConstants.two)) ??
                AppConstants.zero;
      } else {
        cryptoAmount = AppConstants.zero;
      }
    }
    calculateFiatAmount();
  }
}
