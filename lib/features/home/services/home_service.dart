import 'package:aab_crypto_app/core/api/api_provider.dart';
import 'package:aab_crypto_app/core/constants/app_constants.dart';
import 'package:aab_crypto_app/core/localizations/app_strings.dart';
import 'package:aab_crypto_app/features/home/models/asset_model.dart';
import 'package:dartz/dartz.dart';

abstract interface class HomeService {
  Future<Either<String, List<AssetModel>>> fetchAssets();

  Future<Either<String, Map<String, String>>> fetchIcons();
}

class HomeServiceImpl implements HomeService {
  final ApiProvider apiProvider;

  HomeServiceImpl(this.apiProvider);

  @override
  Future<Either<String, List<AssetModel>>> fetchAssets() async {
    try {
      final response =
          await apiProvider.getDio().get(AppConstants.assetsEndpoint);
      if (response.statusCode == AppConstants.codeOk) {
        return Right((response.data as List)
            .map((json) => AssetModel.fromJson(json))
            .toList());
      } else {
        return const Left(AppStrings.fetchAssetsExceptionMessage);
      }
    } catch (e) {
      return const Left(AppStrings.noConnectionMessage);
    }
  }

  @override
  Future<Either<String, Map<String, String>>> fetchIcons() async {
    try {
      final response =
          await apiProvider.getDio().get(AppConstants.iconsEndpoint);
      if (response.statusCode == AppConstants.codeOk) {
        final List<dynamic> icons = response.data;
        var iconUrls = <String, String>{};
        for (var icon in icons) {
          if (icon[AppStrings.assetId] != null &&
              icon[AppStrings.url] != null) {
            iconUrls[icon[AppStrings.assetId]] = icon[AppStrings.url];
          }
        }
        return Right(iconUrls);
      } else {
        return const Left(AppStrings.fetchIconsExceptionMessage);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
