class Item {
  final String name;
  final String price;
  final String iconPath;

  Item({
    required this.name,
    required this.price,
    required this.iconPath,
  });

  factory Item.empty() => Item(name: 'Name', price: 'price', iconPath: 'iconPath');

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'],
      price: json['price'],
      iconPath: json['iconPath'],
    );
  }
}
