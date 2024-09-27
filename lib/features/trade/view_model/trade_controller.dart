import 'package:get/get.dart';
import 'package:dio/dio.dart';

class TradeController extends GetxController {
  var selectedCrypto = 'BTC'.obs;
  var fiatAmount = 0.0.obs;
  var cryptoAmount = 0.0.obs;

  // Hardcoded crypto assets and their prices in USD
  final List<Map<String, dynamic>> cryptoAssets = [
    {'symbol': 'BTC', 'name': 'Bitcoin', 'price': 60000.0},
    {'symbol': 'ETH', 'name': 'Ethereum', 'price': 4000.0},
    {'symbol': 'LTC', 'name': 'Litecoin', 'price': 200.0},
  ];

  void calculateFiatAmount(double cryptoAmount) {
    if (cryptoAmount > 0) {
      var asset = cryptoAssets.firstWhere((element) => element['symbol'] == selectedCrypto.value);
      fiatAmount.value = cryptoAmount * asset['price'];
    } else {
      fiatAmount.value = 0.0;
    }
  }

  void swapFields() {
    var temp = cryptoAmount.value;
    cryptoAmount.value = fiatAmount.value == 0 ? 0.0 : (fiatAmount.value / getSelectedCryptoPrice());
    fiatAmount.value = temp * getSelectedCryptoPrice();
  }

  double getSelectedCryptoPrice() {
    var asset = cryptoAssets.firstWhere((element) => element['symbol'] == selectedCrypto.value);
    return asset['price'];
  }
}