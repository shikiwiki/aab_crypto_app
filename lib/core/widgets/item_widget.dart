import 'package:aab_crypto_app/features/main/view_model/models/item.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.attach_money), // Icon
      title: Text(item.name),
      subtitle: Text(item.price),
      trailing: DropdownButton<String>(
        hint: const Text("Select"),
        value: null, //_selectedAction,
        items: <String>['Buy', 'Sell'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          // setState(() {
          //   _selectedAction = newValue;
          // });
          // // You can perform any action based on the selection here
          // if (newValue == 'Buy') {
          //   // Handle the Buy action
          //   print('Action: Buy');
          // } else if (newValue == 'Sell') {
          //   // Handle the Sell action
          //   print('Action: Sell');
          // }
        },
      ),
    );
  }
}
