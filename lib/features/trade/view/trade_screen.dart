import 'package:aab_crypto_app/features/main/view_model/main_controller.dart';
import 'package:aab_crypto_app/features/trade/view_model/trade_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TradeScreen extends StatelessWidget {
  TradeScreen({super.key});
  final TradeController tradeController = Get.put(TradeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isLoggedIn = Get.find<MainController>().isLoggedIn.value;

      if (!isLoggedIn) {
        return const Center(child: Text('Please log in to access the trade functionality.'));
      }

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: tradeController.selectedCrypto.value,
              items: tradeController.cryptoAssets.map((asset) {
                return DropdownMenuItem<String>(
                  value: asset['symbol'],
                  child: Text(asset['name']),
                );
              }).toList(),
              onChanged: (value) {
                tradeController.selectedCrypto.value = value!;
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Crypto Amount'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                tradeController.calculateFiatAmount(double.tryParse(value) ?? 0);
              },
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(labelText: 'Fiat Amount (USD)'),
              readOnly: true,
              controller: TextEditingController(text: tradeController.fiatAmount.value.toStringAsFixed(2)),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                tradeController.swapFields();
              },
              child: const Text('Swap'),
            ),
          ],
        ),
      );
    });
  }
}
