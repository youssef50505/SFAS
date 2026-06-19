// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Vendor _$VendorFromJson(Map<String, dynamic> json) => _Vendor(
  id: json['id'] as String,
  name: json['name'] as String,
  contactEmail: json['contactEmail'] as String,
  phoneNumber: json['phoneNumber'] as String,
  taxId: json['taxId'] as String,
  address: json['address'] as String,
  createdBy: json['createdBy'] == null
      ? null
      : User.fromJson(json['createdBy'] as Map<String, dynamic>),
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$VendorToJson(_Vendor instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'contactEmail': instance.contactEmail,
  'phoneNumber': instance.phoneNumber,
  'taxId': instance.taxId,
  'address': instance.address,
  'createdBy': instance.createdBy,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};
