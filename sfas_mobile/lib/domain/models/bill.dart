import 'package:freezed_annotation/freezed_annotation.dart';
import 'user.dart';
import 'vendor.dart';

part 'bill.freezed.dart';
part 'bill.g.dart';

@freezed
abstract class Bill with _$Bill {
  const factory Bill({
    String? id,
    String? title,
    Vendor? vendor,
    double? amount,
    double? tax,
    String? date,
    String? imagePath,
    String? description,
    String? status,
    User? createdBy,
    User? reviewedBy,
    String? reviewComments,
    String? createdAt,
    String? updatedAt,
  }) = _Bill;

  factory Bill.fromJson(Map<String, dynamic> json) => _$BillFromJson(json);
}
