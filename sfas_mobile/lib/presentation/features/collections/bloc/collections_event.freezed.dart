// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collections_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CollectionsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CollectionsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CollectionsEvent()';
}


}

/// @nodoc
class $CollectionsEventCopyWith<$Res>  {
$CollectionsEventCopyWith(CollectionsEvent _, $Res Function(CollectionsEvent) __);
}


/// Adds pattern-matching-related methods to [CollectionsEvent].
extension CollectionsEventPatterns on CollectionsEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadCollections value)?  loadCollections,TResult Function( CreateCollection value)?  createCollection,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadCollections() when loadCollections != null:
return loadCollections(_that);case CreateCollection() when createCollection != null:
return createCollection(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadCollections value)  loadCollections,required TResult Function( CreateCollection value)  createCollection,}){
final _that = this;
switch (_that) {
case LoadCollections():
return loadCollections(_that);case CreateCollection():
return createCollection(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadCollections value)?  loadCollections,TResult? Function( CreateCollection value)?  createCollection,}){
final _that = this;
switch (_that) {
case LoadCollections() when loadCollections != null:
return loadCollections(_that);case CreateCollection() when createCollection != null:
return createCollection(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadCollections,TResult Function( Map<String, dynamic> collectionData)?  createCollection,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadCollections() when loadCollections != null:
return loadCollections();case CreateCollection() when createCollection != null:
return createCollection(_that.collectionData);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadCollections,required TResult Function( Map<String, dynamic> collectionData)  createCollection,}) {final _that = this;
switch (_that) {
case LoadCollections():
return loadCollections();case CreateCollection():
return createCollection(_that.collectionData);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadCollections,TResult? Function( Map<String, dynamic> collectionData)?  createCollection,}) {final _that = this;
switch (_that) {
case LoadCollections() when loadCollections != null:
return loadCollections();case CreateCollection() when createCollection != null:
return createCollection(_that.collectionData);case _:
  return null;

}
}

}

/// @nodoc


class LoadCollections implements CollectionsEvent {
  const LoadCollections();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadCollections);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CollectionsEvent.loadCollections()';
}


}




/// @nodoc


class CreateCollection implements CollectionsEvent {
  const CreateCollection(final  Map<String, dynamic> collectionData): _collectionData = collectionData;
  

 final  Map<String, dynamic> _collectionData;
 Map<String, dynamic> get collectionData {
  if (_collectionData is EqualUnmodifiableMapView) return _collectionData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_collectionData);
}


/// Create a copy of CollectionsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateCollectionCopyWith<CreateCollection> get copyWith => _$CreateCollectionCopyWithImpl<CreateCollection>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateCollection&&const DeepCollectionEquality().equals(other._collectionData, _collectionData));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_collectionData));

@override
String toString() {
  return 'CollectionsEvent.createCollection(collectionData: $collectionData)';
}


}

/// @nodoc
abstract mixin class $CreateCollectionCopyWith<$Res> implements $CollectionsEventCopyWith<$Res> {
  factory $CreateCollectionCopyWith(CreateCollection value, $Res Function(CreateCollection) _then) = _$CreateCollectionCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> collectionData
});




}
/// @nodoc
class _$CreateCollectionCopyWithImpl<$Res>
    implements $CreateCollectionCopyWith<$Res> {
  _$CreateCollectionCopyWithImpl(this._self, this._then);

  final CreateCollection _self;
  final $Res Function(CreateCollection) _then;

/// Create a copy of CollectionsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? collectionData = null,}) {
  return _then(CreateCollection(
null == collectionData ? _self._collectionData : collectionData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
