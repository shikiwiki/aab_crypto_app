import 'package:aab_crypto_app/features/main/services/main_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MainController extends GetxController {
  MainController(this.service);

  var isLoggedIn = false.obs;
  final MainService service;

  void toggleLogin() {
    isLoggedIn.value = !isLoggedIn.value;
    final storage = GetStorage();
    storage.write('isLoggedIn', isLoggedIn.value); // Save login state
  }

  void loadLoginState() {
    final storage = GetStorage();
    isLoggedIn.value = storage.read('isLoggedIn') ?? false;
  }
}
