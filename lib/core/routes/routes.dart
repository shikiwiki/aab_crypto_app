import 'package:aab_crypto_app/features/home/view/home_screen.dart';
import 'package:aab_crypto_app/features/main/view/log_in_modal.dart';
import 'package:aab_crypto_app/features/trade/view/trade_screen.dart';
import 'package:get/get.dart';

class Routes {
  static String home = '/';
  static String trade = '/trade';
  static String logIn = '/log_in';

  static String getHomeRoute() => home;

  static String getTradeRoute() => trade;

  static String getSignInRoute() => logIn;

  static List<GetPage> routes = [
    GetPage(name: home, page: () => HomeScreen()),
    GetPage(
      name: trade,
      page: () => const TradeScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: trade,
      page: () => const LogInScreen(),
    ),
  ];
}
