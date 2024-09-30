import 'package:aab_crypto_app/core/api/api_provider.dart';
import 'package:aab_crypto_app/core/constants/app_constants.dart';

abstract interface class HomeService {
  fetchAssets();

  fetchIcons();
}

class HomeServiceImpl implements HomeService {
  final ApiProvider apiProvider;

  HomeServiceImpl(this.apiProvider);

  @override
  fetchAssets() async =>
      await apiProvider.getDio().get(AppConstants.assetsEndpoint);

  @override
  fetchIcons() async =>
      await apiProvider.getDio().get(AppConstants.iconsEndpoint);
}
