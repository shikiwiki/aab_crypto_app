class AssetModel {
  final String name;
  final double? price;
  final String assetId;
  final bool isCrypto;

  AssetModel({
    required this.name,
    required this.price,
    required this.assetId,
    required this.isCrypto,
  });
  factory AssetModel.empty() => AssetModel(name: '', price: 0, assetId: '', isCrypto: false);

  factory AssetModel.fromJson(Map<String, dynamic> json) {
    return AssetModel(
      name: json['name'],
      price: json['price_usd'],
      assetId: json['asset_id'] ?? '',
      isCrypto: json['type_is_crypto'] == 1,
    );
  }
}
