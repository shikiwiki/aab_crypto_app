import 'package:aab_crypto_app/core/api/api_provider.dart';
import 'package:aab_crypto_app/features/home/services/home_service.dart';
import 'package:aab_crypto_app/features/home/view_model/home_controller.dart';
import 'package:aab_crypto_app/features/main/services/main_service.dart';
import 'package:aab_crypto_app/features/main/view_model/main_controller.dart';
import 'package:aab_crypto_app/features/trade/services/trade_service.dart';
import 'package:aab_crypto_app/features/trade/view_model/trade_controller.dart';
import 'package:get/get.dart';

void setupDi() {
  //Register ApiProvider
  Get.lazyPut<ApiProvider>(() => ApiProvider());

  // Register Main dependencies
  Get.lazyPut<MainService>(() => MainServiceImpl());
  Get.lazyPut(() => MainController(Get.find<MainService>()));

  // Register Home dependencies
  Get.lazyPut<HomeService>(() => HomeServiceImpl(Get.find<ApiProvider>()));
  Get.lazyPut(() => HomeController(Get.find<HomeService>()));

  // Register Trade dependencies
  Get.lazyPut<TradeService>(
      () => TradeServiceImpl(Get.find<ApiProvider>()));
  Get.lazyPut(() => TradeController(Get.find<TradeService>()));
}
