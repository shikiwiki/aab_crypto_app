import 'package:aab_crypto_app/core/constants/app_constants.dart';
import 'package:aab_crypto_app/features/home/view_model/models/asset.dart';
import 'package:flutter/material.dart';

class AssetWidget extends StatefulWidget {
  const AssetWidget({
    super.key,
    required this.asset,
    required this.iconUrl,
  });

  final Asset asset;
  final String? iconUrl;

  @override
  State<AssetWidget> createState() => _AssetWidgetState();
}

class _AssetWidgetState extends State<AssetWidget> {
  String? _selectedAction;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: widget.iconUrl != null
          ? Image.network(widget.iconUrl!)
          : const Icon(Icons.attach_money, color: Colors.grey),
      title: Text(widget.asset.name),
      subtitle: (widget.asset.price != null)
          ? Text('${widget.asset.price} USD')
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
