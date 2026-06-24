class Item {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;

  Item({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      category: json['category'] ?? 'OTHER',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'category': category,
    };
  }
}
