import 'package:aab_crypto_app/core/api/api_provider.dart';
import 'package:aab_crypto_app/core/constants/app_constants.dart';
import 'package:aab_crypto_app/core/localizations/app_strings.dart';
import 'package:aab_crypto_app/features/home/models/asset_model.dart';
import 'package:dartz/dartz.dart';

abstract interface class TradeService {
  Future<Either<String, List<AssetModel>>> fetchAssets();
}

class TradeServiceImpl implements TradeService {
  final ApiProvider apiProvider;

  TradeServiceImpl(this.apiProvider);

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
      return Left(e.toString());
    }
  }
}
