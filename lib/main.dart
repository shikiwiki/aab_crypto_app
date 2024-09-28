import 'package:aab_crypto_app/features/main/view/main_screen.dart';
import 'package:aab_crypto_app/features/home/view_model/models/item.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/constants/app_constants.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(const CryptoApp());

  // var items = <Item>[];
  // final Dio dio = Dio();
  // dio.options.headers['Content-Type'] = AppConstants.contentType;
  // dio.options.headers['X-CoinAPI-Key'] = AppConstants.apiKey;
  // try {
  //   final response = await dio.get('${AppConstants.baseUrl}/v1/assets');
  //
  //   if (response.statusCode == 200) {
  //     debugPrint('API_RESPONSE: ${response.data}');
  //     // List assets = response.data;
  //     List<Item> newItems =
  //         (response.data as List).map((json) => Item.fromJson(json)).toList();
  //     items.addAll(newItems);
  //     debugPrint('ITEMS_LIST contains ${items.length} items:\n');
  //     debugPrint('Fifth item: ${items[1].name} -- ${items[1].price} -- ${items[1].iconId}\n');
  //     // for (Item item in items) {
  //     //   debugPrint('${item.iconId}, ${item.name}, ${item.price}\n');
  //     // }
  //   } else {
  //     throw Exception('Failed to load items');
  //   }
  // } catch (e) {
  //   debugPrint(e.toString());
  // }
}

class CryptoApp extends StatelessWidget {
  const CryptoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: MainScreen(),
    );
  }
}
