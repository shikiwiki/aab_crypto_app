import 'package:aab_crypto_app/core/api/api_provider.dart';
import 'package:aab_crypto_app/core/constants/app_constants.dart';
import 'package:aab_crypto_app/core/localizations/app_strings.dart';
import 'package:aab_crypto_app/features/home/models/asset_model.dart';
import 'package:flutter/foundation.dart';

abstract interface class HomeService {
  Future<List<AssetModel>> fetchAssets();

  Future<Map<String, String>> fetchIcons();
}

class HomeServiceImpl implements HomeService {
  final ApiProvider apiProvider;

  HomeServiceImpl(this.apiProvider);

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

  @override
  Future<Map<String, String>> fetchIcons() async {
    try {
      var iconUrls = <String, String>{};
      final response =
          await apiProvider.getDio().get(AppConstants.iconsEndpoint);
      if (response.statusCode == AppConstants.codeOk) {
        final List<dynamic> icons = response.data;
        for (var icon in icons) {
          if (icon[AppStrings.assetId] != null &&
              icon[AppStrings.url] != null) {
            iconUrls[icon[AppStrings.assetId]] = icon[AppStrings.url];
          }
        }
        return iconUrls;
      } else {
        throw Exception(AppStrings.fetchAssetsExceptionMessage);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return <String, String>{};
  }
}
