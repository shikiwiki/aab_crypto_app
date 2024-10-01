import 'package:aab_crypto_app/core/localizations/app_strings.dart';
import 'package:aab_crypto_app/features/home/enums/option.dart';
import 'package:aab_crypto_app/features/home/models/asset_model.dart';
import 'package:flutter/material.dart';

class AssetWidget extends StatefulWidget {
  const AssetWidget({
    super.key,
    required this.asset,
    required this.iconUrl,
  });

  final AssetModel asset;
  final String? iconUrl;

  @override
  State<AssetWidget> createState() => _AssetWidgetState();
}

class _AssetWidgetState extends State<AssetWidget> {
  Option? _selectedAction;

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
      trailing: DropdownButton<Option>(
        hint: const Text(AppStrings.select),
        value: _selectedAction,
        items: Option.values.map((Option value) {
          return DropdownMenuItem<Option>(
            value: value,
            child: Text(value.name),
          );
        }).toList(),
        onChanged: (Option? newValue) {
          setState(() {
            _selectedAction = newValue;
          });
        },
      ),
    );
  }
}
