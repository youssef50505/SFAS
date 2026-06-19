import 'package:freezed_annotation/freezed_annotation.dart';
import 'user.dart';

part 'report.freezed.dart';
part 'report.g.dart';

@freezed
class Report with _$Report {
  const factory Report({
    required String id,
    required String date,
    required String title,
    required String description,
    required String typeOfReport,
    User? createdBy,
    String? createdAt,
    String? updatedAt,
  }) = _Report;

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);
}
