// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Bill _$BillFromJson(Map<String, dynamic> json) => _Bill(
  id: json['id'] as String,
  title: json['title'] as String,
  vendor: json['vendor'] == null
      ? null
      : Vendor.fromJson(json['vendor'] as Map<String, dynamic>),
  amount: (json['amount'] as num).toDouble(),
  tax: (json['tax'] as num).toDouble(),
  date: json['date'] as String,
  imagePath: json['imagePath'] as String?,
  description: json['description'] as String,
  status: json['status'] as String,
  createdBy: json['createdBy'] == null
      ? null
      : User.fromJson(json['createdBy'] as Map<String, dynamic>),
  reviewedBy: json['reviewedBy'] == null
      ? null
      : User.fromJson(json['reviewedBy'] as Map<String, dynamic>),
  reviewComments: json['reviewComments'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$BillToJson(_Bill instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'vendor': instance.vendor,
  'amount': instance.amount,
  'tax': instance.tax,
  'date': instance.date,
  'imagePath': instance.imagePath,
  'description': instance.description,
  'status': instance.status,
  'createdBy': instance.createdBy,
  'reviewedBy': instance.reviewedBy,
  'reviewComments': instance.reviewComments,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};
