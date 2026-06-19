import 'package:freezed_annotation/freezed_annotation.dart';

part 'collections_event.freezed.dart';

@freezed
class CollectionsEvent with _$CollectionsEvent {
  const factory CollectionsEvent.loadCollections() = LoadCollections;
  const factory CollectionsEvent.createCollection(Map<String, dynamic> collectionData) = CreateCollection;
}
