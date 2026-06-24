class Report {
  final String id;
  final String type;
  final String format;
  final String generatedAt;
  final String downloadUrl;
  final String parameters;

  Report({
    required this.id,
    required this.type,
    required this.format,
    required this.generatedAt,
    required this.downloadUrl,
    required this.parameters,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      format: json['format'] ?? '',
      generatedAt: json['generatedAt'] ?? '',
      downloadUrl: json['downloadUrl'] ?? '',
      parameters: json['parameters'] ?? '',
    );
  }
}
