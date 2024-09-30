import 'package:aab_crypto_app/core/constants/app_constants.dart';
import 'package:aab_crypto_app/features/main/view_model/main_controller.dart';
import 'package:aab_crypto_app/features/trade/view_model/trade_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TradeScreen extends StatelessWidget {
  final TradeController tradeController = Get.put(TradeController());
  final TextEditingController cryptoAmountController = TextEditingController();

  TradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isLoggedIn = Get.find<MainController>().isLoggedIn.value;

      if (!isLoggedIn) {
        return const Center(child: Text(AppConstants.noAccessMessage));
      }
      cryptoAmountController.text = tradeController.cryptoAmount.toString();

      return Padding(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            DropdownButton<String>(
              hint: const Text(AppConstants.chooseAsset),
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
                if (cryptoAmountController.text == '0.0' ||
                    cryptoAmountController.text.isEmpty) {
                  cryptoAmountController.clear();
                }
              },
              onChanged: (value) {
                if (value.isNotEmpty) {
                  tradeController.cryptoAmount = num.tryParse(value) ?? 0;
                  tradeController.calculateFiatAmount();
                } else {
                  tradeController.cryptoAmount = 0;
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
                text: tradeController.fiatAmount.value.toStringAsFixed(2),
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
