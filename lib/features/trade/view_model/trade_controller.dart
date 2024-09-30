import 'package:aab_crypto_app/core/constants/app_constants.dart';
import 'package:aab_crypto_app/features/home/view_model/models/asset.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class TradeController extends GetxController {
  var fiatAmount = 0.0.obs;
  var currentAsset = Asset.empty().obs;
  var cryptoAssets = <Asset>[].obs;
  num cryptoAmount = 0;

  final Dio dio = Dio()
    ..options.headers[AppConstants.contentTypeHeader] = AppConstants.contentType
    ..options.headers[AppConstants.apiKeyHeader] = AppConstants.apiKey;

  @override
  void onInit() {
    super.onInit();
    fetchCryptoAssets();
  }

  void selectItem(String name) {
    final selectedItem = cryptoAssets.firstWhere(
      (asset) => asset.name == name,
      orElse: () => Asset.empty(),
    );
    currentAsset.value = selectedItem;
    calculateFiatAmount();
  }

  Future<void> fetchCryptoAssets() async {
    try {
      final response = await dio.get('${AppConstants.baseUrl}/v1/assets');

      if (response.statusCode == 200) {
        List<Asset> allAssets = (response.data as List)
            .map((json) => Asset.fromJson(json))
            .toList();
        List<Asset> cryptoItems = [];
        for (var asset in allAssets) {
          if (asset.isCrypto) cryptoItems.add(asset);
        }
        cryptoAssets.value =
            cryptoItems.where((asset) => asset.price != null).toList();
      } else {
        throw Exception('Failed to load assets');
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
    if (currentAsset.value.price != null && currentAsset.value.price! > 0) {
      if (fiatAmount.value > 0) {
        cryptoAmount = fiatAmount.value;
      } else {
        cryptoAmount = 0.0;
      }
    }
    calculateFiatAmount();
  }
}
