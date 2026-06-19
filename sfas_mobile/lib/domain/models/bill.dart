import 'package:freezed_annotation/freezed_annotation.dart';
import 'user.dart';
import 'vendor.dart';

part 'bill.freezed.dart';
part 'bill.g.dart';

@freezed
abstract class Bill with _$Bill {
  const factory Bill({
    required String id,
    required String title,
    Vendor? vendor,
    required double amount,
    required double tax,
    required String date,
    String? imagePath,
    required String description,
    required String status,
    User? createdBy,
    User? reviewedBy,
    String? reviewComments,
    String? createdAt,
    String? updatedAt,
  }) = _Bill;

  factory Bill.fromJson(Map<String, dynamic> json) => _$BillFromJson(json);
}
