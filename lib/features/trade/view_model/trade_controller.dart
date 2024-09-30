import 'package:aab_crypto_app/core/constants/app_constants.dart';
import 'package:aab_crypto_app/core/localizations/app_strings.dart';
import 'package:aab_crypto_app/features/home/models/asset_model.dart';
import 'package:aab_crypto_app/features/trade/services/trade_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class TradeController extends GetxController {
  var fiatAmount = AppConstants.zero.obs;
  var currentAsset = AssetModel.empty().obs;
  var cryptoAssets = <AssetModel>[].obs;
  num cryptoAmount = AppConstants.zero;
  final TradeService tradeService;

  TradeController(this.tradeService);

  @override
  void onInit() {
    super.onInit();
    fetchAssets();
  }

  void selectItem(String name) {
    final selectedItem = cryptoAssets.firstWhere(
      (asset) => asset.name == name,
      orElse: () => AssetModel.empty(),
    );
    currentAsset.value = selectedItem;
    calculateFiatAmount();
  }

  Future<void> fetchAssets() async {
    try {
      final response = await tradeService.fetchAssets();

      if (response.statusCode == AppConstants.codeOk) {
        List<AssetModel> allAssets = (response.data as List)
            .map((json) => AssetModel.fromJson(json))
            .toList();
        for (var asset in allAssets) {
          if (asset.isCrypto && asset.price != null) cryptoAssets.add(asset);
        }
      } else {
        throw Exception(AppStrings.fetchAssetsExceptionMessage);
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
    if (currentAsset.value.price != null &&
        currentAsset.value.price! > AppConstants.zero) {
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
