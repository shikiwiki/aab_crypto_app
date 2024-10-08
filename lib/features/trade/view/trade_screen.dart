import 'package:aab_crypto_app/core/constants/app_constants.dart';
import 'package:aab_crypto_app/core/localizations/app_strings.dart';
import 'package:aab_crypto_app/core/utils/extensions/string_helper.dart';
import 'package:aab_crypto_app/features/main/view_model/main_controller.dart';
import 'package:aab_crypto_app/features/trade/view_model/trade_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TradeScreen extends StatefulWidget {
  const TradeScreen({super.key});

  @override
  State<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen> {
  final TradeController tradeController = Get.find<TradeController>();

  final TextEditingController cryptoAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cryptoAmountController.text = tradeController.cryptoAmount.toString();
    cryptoAmountController.addListener(_onCryptoAmountChange);
  }

  void _onCryptoAmountChange() {
    String cleanValue = cryptoAmountController.text.cleanInput();
    if (cleanValue.isEmpty) {
      tradeController.cryptoAmount = AppConstants.zero;
      cryptoAmountController.text = AppStrings.zeroString;
      return;
    } else {
      if (cleanValue != cryptoAmountController.text) {
        cryptoAmountController.text = cleanValue;
      }
      if (cleanValue.isNotEmpty &&
          cleanValue.split(AppStrings.dot).length <= AppConstants.two) {
        tradeController.cryptoAmount =
            num.tryParse(cleanValue) ?? AppConstants.zero;
      }
    }
    tradeController.calculateFiatAmount();
  }

  @override
  void dispose() {
    cryptoAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isLoggedIn = Get.find<MainController>().isLoggedIn.value;

      if (!isLoggedIn) {
        return const Center(child: Text(AppStrings.noAccessMessage));
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
              hint: const Text(AppStrings.selectAsset),
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
            TextFormField(
              controller: cryptoAmountController,
              decoration:
                  const InputDecoration(labelText: AppStrings.cryptoAmount),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              onTap: () {
                if (cryptoAmountController.text.isEmpty ||
                    cryptoAmountController.text == AppStrings.zeroString) {
                  cryptoAmountController.clear();
                }
              },
            ),
            const SizedBox(height: AppConstants.separatorMedium),
            TextField(
              decoration:
                  const InputDecoration(labelText: AppStrings.fiatAmount),
              textAlign: TextAlign.center,
              readOnly: true,
              controller: TextEditingController(
                text: tradeController.fiatAmount.value
                    .toStringAsFixed(AppConstants.two),
              ),
            ),
            const SizedBox(height: AppConstants.separatorMedium),
            ElevatedButton(
              onPressed: () {
                tradeController.swapFields();
              },
              child: const Text(AppStrings.swap),
            ),
          ],
        ),
      );
    });
  }
}
