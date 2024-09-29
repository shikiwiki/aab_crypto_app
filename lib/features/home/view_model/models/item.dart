class Item {
  final String name;
  final double? price;
  final String iconId;
  final dynamic isCrypto;

  Item({
    required this.name,
    required this.price,
    required this.iconId,
    required this.isCrypto,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'],
      price: json['price_usd'],
      iconId: json['id_icon'] ?? '',
      isCrypto: json['type_is_crypto'] == 1,
    );
  }
}
