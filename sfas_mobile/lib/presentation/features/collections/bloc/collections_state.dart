import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/models/collection.dart';

part 'collections_state.freezed.dart';

@freezed
class CollectionsState with _$CollectionsState {
  const factory CollectionsState.initial() = _Initial;
  const factory CollectionsState.loading() = _Loading;
  const factory CollectionsState.loaded(List<Collection> collections) = _Loaded;
  const factory CollectionsState.error(String message) = _Error;
}
