class Fund {
  final String id;
  final String title;
  final String description;
  final double amountOfFund;
  final String urgencyLevel;
  final String date;
  final String status;

  Fund({
    required this.id,
    required this.title,
    required this.description,
    required this.amountOfFund,
    required this.urgencyLevel,
    required this.date,
    required this.status,
  });

  factory Fund.fromJson(Map<String, dynamic> json) {
    return Fund(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      amountOfFund: (json['amountOfFund'] ?? 0).toDouble(),
      urgencyLevel: json['urgencyLevel'] ?? 'LOW',
      date: json['date'] ?? DateTime.now().toIso8601String(),
      status: json['status'] ?? 'PENDING',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'amountOfFund': amountOfFund,
      'urgencyLevel': urgencyLevel,
      'date': date,
      'status': status,
    };
  }
}
