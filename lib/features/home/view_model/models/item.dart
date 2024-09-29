class Item {
  final String name;
  final double? price;
  final String assetId;
  final bool isCrypto;

  Item({
    required this.name,
    required this.price,
    required this.assetId,
    required this.isCrypto,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'],
      price: json['price_usd'],
      assetId: json['asset_id'] ?? '',
      isCrypto: json['type_is_crypto'] == 1,
    );
  }
}
