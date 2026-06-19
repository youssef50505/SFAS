// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Report _$ReportFromJson(Map<String, dynamic> json) => _Report(
  id: json['id'] as String,
  date: json['date'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  typeOfReport: json['typeOfReport'] as String,
  createdBy: json['createdBy'] == null
      ? null
      : User.fromJson(json['createdBy'] as Map<String, dynamic>),
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$ReportToJson(_Report instance) => <String, dynamic>{
  'id': instance.id,
  'date': instance.date,
  'title': instance.title,
  'description': instance.description,
  'typeOfReport': instance.typeOfReport,
  'createdBy': instance.createdBy,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};
