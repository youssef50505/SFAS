class Fund {
  final String id;
  final String name;
  final double initialAmount;
  final String status;
  final String dateCreated;

  Fund({
    required this.id,
    required this.name,
    required this.initialAmount,
    required this.status,
    required this.dateCreated,
  });

  factory Fund.fromJson(Map<String, dynamic> json) {
    return Fund(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      initialAmount: (json['initialAmount'] ?? 0).toDouble(),
      status: json['status'] ?? 'ACTIVE',
      dateCreated: json['dateCreated'] ?? DateTime.now().toIso8601String(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'initialAmount': initialAmount,
      'status': status,
    };
  }
}
