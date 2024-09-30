import 'package:aab_crypto_app/core/api/api_provider.dart';
import 'package:aab_crypto_app/core/constants/app_constants.dart';

abstract interface class TradeService {
  fetchAssets();
}

class TradeServiceImpl implements TradeService {
  final ApiProvider apiProvider;

  TradeServiceImpl(this.apiProvider);

  @override
  fetchAssets() async => await apiProvider.getDio().get(AppConstants.assetsEndpoint);
}
