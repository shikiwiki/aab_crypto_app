import 'package:aab_crypto_app/core/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MainController extends GetxController {
  var isLoggedIn = false.obs;
  var userEmail = AppConstants.empty.obs;

  // void toggleLogin() {
  //   isLoggedIn.value = !isLoggedIn.value;
  //   final storage = GetStorage();
  //   storage.write(AppConstants.isLoggedIn, isLoggedIn.value);
  // }

  void login(String email, String password) {
    isLoggedIn.value = true;
    userEmail.value = email; // Set the user email
    final storage = GetStorage();
    storage.write(AppConstants.isLoggedIn, true);
    storage.write(AppConstants.userEmailKey, userEmail.value);
  }

  void loadLoginState() {
    final storage = GetStorage();
    isLoggedIn.value = storage.read(AppConstants.isLoggedIn) ?? false;
  }

  void logout() {
    isLoggedIn.value = false;
    final storage = GetStorage();
    storage.remove(AppConstants.isLoggedIn);
    Get.snackbar(AppConstants.loggedOut, AppConstants.loggedOutMessage);
  }
}
