// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'funds_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FundsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FundsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FundsEvent()';
}


}

/// @nodoc
class $FundsEventCopyWith<$Res>  {
$FundsEventCopyWith(FundsEvent _, $Res Function(FundsEvent) __);
}


/// Adds pattern-matching-related methods to [FundsEvent].
extension FundsEventPatterns on FundsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadFunds value)?  loadFunds,TResult Function( CreateFund value)?  createFund,TResult Function( UpdateFundStatus value)?  updateFundStatus,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadFunds() when loadFunds != null:
return loadFunds(_that);case CreateFund() when createFund != null:
return createFund(_that);case UpdateFundStatus() when updateFundStatus != null:
return updateFundStatus(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadFunds value)  loadFunds,required TResult Function( CreateFund value)  createFund,required TResult Function( UpdateFundStatus value)  updateFundStatus,}){
final _that = this;
switch (_that) {
case LoadFunds():
return loadFunds(_that);case CreateFund():
return createFund(_that);case UpdateFundStatus():
return updateFundStatus(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadFunds value)?  loadFunds,TResult? Function( CreateFund value)?  createFund,TResult? Function( UpdateFundStatus value)?  updateFundStatus,}){
final _that = this;
switch (_that) {
case LoadFunds() when loadFunds != null:
return loadFunds(_that);case CreateFund() when createFund != null:
return createFund(_that);case UpdateFundStatus() when updateFundStatus != null:
return updateFundStatus(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadFunds,TResult Function( Map<String, dynamic> fundData)?  createFund,TResult Function( String fundId,  String status)?  updateFundStatus,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadFunds() when loadFunds != null:
return loadFunds();case CreateFund() when createFund != null:
return createFund(_that.fundData);case UpdateFundStatus() when updateFundStatus != null:
return updateFundStatus(_that.fundId,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadFunds,required TResult Function( Map<String, dynamic> fundData)  createFund,required TResult Function( String fundId,  String status)  updateFundStatus,}) {final _that = this;
switch (_that) {
case LoadFunds():
return loadFunds();case CreateFund():
return createFund(_that.fundData);case UpdateFundStatus():
return updateFundStatus(_that.fundId,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadFunds,TResult? Function( Map<String, dynamic> fundData)?  createFund,TResult? Function( String fundId,  String status)?  updateFundStatus,}) {final _that = this;
switch (_that) {
case LoadFunds() when loadFunds != null:
return loadFunds();case CreateFund() when createFund != null:
return createFund(_that.fundData);case UpdateFundStatus() when updateFundStatus != null:
return updateFundStatus(_that.fundId,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class LoadFunds implements FundsEvent {
  const LoadFunds();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadFunds);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FundsEvent.loadFunds()';
}


}




/// @nodoc


class CreateFund implements FundsEvent {
  const CreateFund(final  Map<String, dynamic> fundData): _fundData = fundData;
  

 final  Map<String, dynamic> _fundData;
 Map<String, dynamic> get fundData {
  if (_fundData is EqualUnmodifiableMapView) return _fundData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_fundData);
}


/// Create a copy of FundsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateFundCopyWith<CreateFund> get copyWith => _$CreateFundCopyWithImpl<CreateFund>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateFund&&const DeepCollectionEquality().equals(other._fundData, _fundData));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_fundData));

@override
String toString() {
  return 'FundsEvent.createFund(fundData: $fundData)';
}


}

/// @nodoc
abstract mixin class $CreateFundCopyWith<$Res> implements $FundsEventCopyWith<$Res> {
  factory $CreateFundCopyWith(CreateFund value, $Res Function(CreateFund) _then) = _$CreateFundCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> fundData
});




}
/// @nodoc
class _$CreateFundCopyWithImpl<$Res>
    implements $CreateFundCopyWith<$Res> {
  _$CreateFundCopyWithImpl(this._self, this._then);

  final CreateFund _self;
  final $Res Function(CreateFund) _then;

/// Create a copy of FundsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? fundData = null,}) {
  return _then(CreateFund(
null == fundData ? _self._fundData : fundData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

/// @nodoc


class UpdateFundStatus implements FundsEvent {
  const UpdateFundStatus(this.fundId, this.status);
  

 final  String fundId;
 final  String status;

/// Create a copy of FundsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateFundStatusCopyWith<UpdateFundStatus> get copyWith => _$UpdateFundStatusCopyWithImpl<UpdateFundStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateFundStatus&&(identical(other.fundId, fundId) || other.fundId == fundId)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,fundId,status);

@override
String toString() {
  return 'FundsEvent.updateFundStatus(fundId: $fundId, status: $status)';
}


}

/// @nodoc
abstract mixin class $UpdateFundStatusCopyWith<$Res> implements $FundsEventCopyWith<$Res> {
  factory $UpdateFundStatusCopyWith(UpdateFundStatus value, $Res Function(UpdateFundStatus) _then) = _$UpdateFundStatusCopyWithImpl;
@useResult
$Res call({
 String fundId, String status
});




}
/// @nodoc
class _$UpdateFundStatusCopyWithImpl<$Res>
    implements $UpdateFundStatusCopyWith<$Res> {
  _$UpdateFundStatusCopyWithImpl(this._self, this._then);

  final UpdateFundStatus _self;
  final $Res Function(UpdateFundStatus) _then;

/// Create a copy of FundsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? fundId = null,Object? status = null,}) {
  return _then(UpdateFundStatus(
null == fundId ? _self.fundId : fundId // ignore: cast_nullable_to_non_nullable
as String,null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
