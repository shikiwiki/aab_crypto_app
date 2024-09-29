class Asset {
  final String name;
  final double? price;
  final String assetId;
  final bool isCrypto;

  Asset({
    required this.name,
    required this.price,
    required this.assetId,
    required this.isCrypto,
  });
  factory Asset.empty() => Asset(name: '', price: 0, assetId: '', isCrypto: false);

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      name: json['name'],
      price: json['price_usd'],
      assetId: json['asset_id'] ?? '',
      isCrypto: json['type_is_crypto'] == 1,
    );
  }
}
