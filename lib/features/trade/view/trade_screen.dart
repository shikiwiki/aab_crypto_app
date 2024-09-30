import 'package:aab_crypto_app/core/constants/app_constants.dart';
import 'package:aab_crypto_app/features/main/view_model/main_controller.dart';
import 'package:aab_crypto_app/features/trade/view_model/trade_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TradeScreen extends StatelessWidget {
  final TradeController tradeController = Get.put(TradeController());
  final TextEditingController cryptoAmountController = TextEditingController();

  TradeScreen({super.key}) {
    cryptoAmountController.text = tradeController.cryptoAmount.toString();

    cryptoAmountController.addListener(() {
      String correctValue =
          cryptoAmountController.text.replaceAll(RegExp(r'[^0-9.]'), '');
      if (correctValue.isNotEmpty &&
          correctValue.split('.').length <= AppConstants.two) {
        tradeController.cryptoAmount =
            num.tryParse(correctValue) ?? AppConstants.zero;
      }
      tradeController.calculateFiatAmount();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isLoggedIn = Get.find<MainController>().isLoggedIn.value;

      if (!isLoggedIn) {
        return const Center(child: Text(AppConstants.noAccessMessage));
      }
      if (cryptoAmountController.text !=
          tradeController.cryptoAmount.toString()) {
        cryptoAmountController.text = tradeController.cryptoAmount.toString();
      }
      return Padding(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            DropdownButton<String>(
              hint: const Text(AppConstants.selectAsset),
              value: tradeController.currentAsset.value.name.isNotEmpty
                  ? tradeController.currentAsset.value.name
                  : null,
              items: tradeController.cryptoAssets.map((asset) {
                return DropdownMenuItem<String>(
                  value: asset.name,
                  child: Text(asset.name),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  tradeController.selectItem(value);
                }
              },
            ),
            TextField(
              controller: cryptoAmountController,
              decoration:
                  const InputDecoration(labelText: AppConstants.cryptoAmount),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              onTap: () {
                if (cryptoAmountController.text.isEmpty ||
                    cryptoAmountController.text == AppConstants.zeroString) {
                  cryptoAmountController.clear();
                }
              },
            ),
            const SizedBox(height: AppConstants.separatorSize),
            TextField(
              decoration:
                  const InputDecoration(labelText: AppConstants.fiatAmount),
              textAlign: TextAlign.center,
              readOnly: true,
              controller: TextEditingController(
                text: tradeController.fiatAmount.value
                    .toStringAsFixed(AppConstants.two),
              ),
            ),
            const SizedBox(height: AppConstants.separatorSize),
            ElevatedButton(
              onPressed: () {
                tradeController.swapFields();
              },
              child: const Text(AppConstants.swap),
            ),
          ],
        ),
      );
    });
  }
}
