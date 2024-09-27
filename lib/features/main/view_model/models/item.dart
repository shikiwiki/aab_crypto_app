class Item {
  final String name;
  final double price;

  Item({required this.name, required this.price});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'],
      price: json['price'].toDouble(),
    );
  }
}
