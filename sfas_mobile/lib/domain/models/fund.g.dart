// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fund.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Fund _$FundFromJson(Map<String, dynamic> json) => _Fund(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  amountOfFund: (json['amountOfFund'] as num).toDouble(),
  urgencyLevel: json['urgencyLevel'] as String,
  date: json['date'] as String,
  imagePath: json['imagePath'] as String?,
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

Map<String, dynamic> _$FundToJson(_Fund instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'amountOfFund': instance.amountOfFund,
  'urgencyLevel': instance.urgencyLevel,
  'date': instance.date,
  'imagePath': instance.imagePath,
  'status': instance.status,
  'createdBy': instance.createdBy,
  'reviewedBy': instance.reviewedBy,
  'reviewComments': instance.reviewComments,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};
