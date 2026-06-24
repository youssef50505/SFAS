class CollectionMetrics {
  final double today;
  final double weekly;
  final double monthly;
  final double annually;

  CollectionMetrics({
    required this.today,
    required this.weekly,
    required this.monthly,
    required this.annually,
  });

  factory CollectionMetrics.fromJson(Map<String, dynamic> json) {
    return CollectionMetrics(
      today: (json['today'] ?? 0).toDouble(),
      weekly: (json['weekly'] ?? 0).toDouble(),
      monthly: (json['monthly'] ?? 0).toDouble(),
      annually: (json['annually'] ?? 0).toDouble(),
    );
  }
}
