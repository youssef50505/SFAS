import 'package:freezed_annotation/freezed_annotation.dart';
import 'user.dart';

part 'vendor.freezed.dart';
part 'vendor.g.dart';

@freezed
abstract class Vendor with _$Vendor {
  const factory Vendor({
    required String id,
    required String name,
    required String contactEmail,
    required String phoneNumber,
    required String taxId,
    required String address,
    User? createdBy,
    String? createdAt,
    String? updatedAt,
  }) = _Vendor;

  factory Vendor.fromJson(Map<String, dynamic> json) => _$VendorFromJson(json);
}
