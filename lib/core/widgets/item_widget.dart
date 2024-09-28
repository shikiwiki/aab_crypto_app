import 'package:aab_crypto_app/core/constants/app_constants.dart';
import 'package:aab_crypto_app/features/home/view_model/models/item.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatefulWidget {
  const ItemWidget({super.key, required this.item});

  final Item item;

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  String? _selectedAction;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.attach_money), // Icon
      title: Text(widget.item.name),
      subtitle:(widget.item.price != null)
          ? Text('${widget.item.price} USD')
          : const SizedBox.shrink(),
      trailing: DropdownButton<String>(
        hint: const Text(AppConstants.select),
        value: _selectedAction,
        items:
            <String>[AppConstants.buy, AppConstants.sell].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedAction = newValue;
          });
          //TODO(me): implement at spare time
          if (newValue == AppConstants.buy) {
            print('Action: Buy');
          } else if (newValue == AppConstants.sell) {
            print('Action: Sell');
          }
        },
      ),
    );
  }
}
