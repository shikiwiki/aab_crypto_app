import 'package:aab_crypto_app/core/api/api_provider.dart';
import 'package:aab_crypto_app/core/constants/app_constants.dart';
import 'package:aab_crypto_app/core/localizations/app_strings.dart';
import 'package:aab_crypto_app/features/home/models/asset_model.dart';
import 'package:flutter/foundation.dart';

abstract interface class TradeService {
  Future<List<AssetModel>> fetchAssets();
}

class TradeServiceImpl implements TradeService {
  final ApiProvider apiProvider;

  TradeServiceImpl(this.apiProvider);

  @override
  Future<List<AssetModel>> fetchAssets() async {
    try {
      final response =
          await apiProvider.getDio().get(AppConstants.assetsEndpoint);
      if (response.statusCode == AppConstants.codeOk) {
        return (response.data as List)
            .map((json) => AssetModel.fromJson(json))
            .toList();
      } else {
        throw Exception(AppStrings.fetchAssetsExceptionMessage);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return List<AssetModel>.empty();
  }
}
