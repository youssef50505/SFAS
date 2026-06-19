import 'package:freezed_annotation/freezed_annotation.dart';
import 'user.dart';

part 'collection.freezed.dart';
part 'collection.g.dart';

@freezed
abstract class Collection with _$Collection {
  const factory Collection({
    required String id,
    required String date,
    required String type,
    required double amount,
    User? createdBy,
    String? createdAt,
    String? updatedAt,
  }) = _Collection;

  factory Collection.fromJson(Map<String, dynamic> json) => _$CollectionFromJson(json);
}
