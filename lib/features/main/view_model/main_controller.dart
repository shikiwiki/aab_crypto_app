import 'package:aab_crypto_app/features/main/services/main_service.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  MainController(this.service);

  var isLoggedIn = false.obs;
  final MainService service;

  void toggleLogin() {
    isLoggedIn.value = !isLoggedIn.value;
  }
}
