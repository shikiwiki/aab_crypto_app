class Item {
  final String name;
  final String? price;
  final String iconId;

  Item({
    required this.name,
    required this.price,
    required this.iconId,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'],
      price: json['price_usd']?.toString(),
      iconId: json['id_icon'] ?? '',
    );
  }
}
