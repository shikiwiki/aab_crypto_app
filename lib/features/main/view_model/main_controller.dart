import 'package:aab_crypto_app/core/localizations/app_strings.dart';
import 'package:aab_crypto_app/features/main/services/main_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MainController extends GetxController {
  var isLoggedIn = false.obs;
  var userEmail = AppStrings.empty.obs;
  final MainService mainService;

  MainController(this.mainService);

  void login(String email, String password) {
    isLoggedIn.value = true;
    userEmail.value = email;
    final storage = GetStorage();
    storage.write(AppStrings.isLoggedIn, true);
    storage.write(AppStrings.userEmailKey, userEmail.value);
  }

  void loadLoginState() {
    final storage = GetStorage();
    isLoggedIn.value = storage.read(AppStrings.isLoggedIn) ?? false;
  }

  void logout() {
    isLoggedIn.value = false;
    final storage = GetStorage();
    storage.remove(AppStrings.isLoggedIn);
    Get.snackbar(AppStrings.loggedOut, AppStrings.loggedOutMessage);
  }
}
