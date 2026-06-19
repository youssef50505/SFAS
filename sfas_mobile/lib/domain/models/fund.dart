import 'package:freezed_annotation/freezed_annotation.dart';
import 'user.dart';

part 'fund.freezed.dart';
part 'fund.g.dart';

@freezed
class Fund with _$Fund {
  const factory Fund({
    required String id,
    required String title,
    required String description,
    required double amountOfFund,
    required String urgencyLevel,
    required String date,
    String? imagePath,
    required String status,
    User? createdBy,
    User? reviewedBy,
    String? reviewComments,
    String? createdAt,
    String? updatedAt,
  }) = _Fund;

  factory Fund.fromJson(Map<String, dynamic> json) => _$FundFromJson(json);
}
