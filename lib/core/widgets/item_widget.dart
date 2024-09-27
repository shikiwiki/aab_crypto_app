import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.attach_money), // Icon
      title: const Text('Price'), // Price
      subtitle: const Text('Item Name'), // Name
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