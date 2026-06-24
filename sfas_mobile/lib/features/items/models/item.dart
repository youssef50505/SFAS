class Item {
  final String id;
  final String name;
  final String description;
  final double unitPrice;
  final int currentStock;

  Item({
    required this.id,
    required this.name,
    required this.description,
    required this.unitPrice,
    required this.currentStock,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      unitPrice: (json['unitPrice'] ?? 0).toDouble(),
      currentStock: json['currentStock'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'unitPrice': unitPrice,
      'currentStock': currentStock,
    };
  }
}
