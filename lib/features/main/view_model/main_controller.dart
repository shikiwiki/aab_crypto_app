import 'package:aab_crypto_app/core/localizations/app_strings.dart';
import 'package:aab_crypto_app/features/main/services/main_service.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  var isLoggedIn = false.obs;
  var userEmail = AppStrings.empty.obs;
  final MainService mainService;

  MainController(this.mainService);

  void login(String email, String password) {
    userEmail.value = email;
    mainService.write(AppStrings.isLoggedIn, true);
    mainService.write(AppStrings.userEmailKey, userEmail.value);
    isLoggedIn.value = true;
  }

  void loadLoginState() {
    isLoggedIn.value = mainService.read(AppStrings.isLoggedIn) ?? false;
  }

  void logout() {
    isLoggedIn.value = false;
    mainService.remove(AppStrings.isLoggedIn);
  }
}
