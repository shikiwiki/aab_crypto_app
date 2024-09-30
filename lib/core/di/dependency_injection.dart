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

  // Register MainService
  Get.lazyPut<MainServiceImpl>(() => MainServiceImpl());

  // Register HomeService
  Get.lazyPut<HomeServiceImpl>(() => HomeServiceImpl(Get.find<ApiProvider>()));

  // Register TradeService
  Get.lazyPut<TradeServiceImpl>(() => TradeServiceImpl(Get.find<ApiProvider>()));

  Get.lazyPut(() => MainController(Get.find<MainServiceImpl>()));

  Get.lazyPut(() => HomeController(Get.find<HomeServiceImpl>()));

  //Register Trade dependencies
  Get.lazyPut(() => TradeController(Get.find<TradeServiceImpl>()));
}