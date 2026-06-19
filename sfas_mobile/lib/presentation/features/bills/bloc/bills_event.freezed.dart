// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bills_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BillsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BillsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BillsEvent()';
}


}

/// @nodoc
class $BillsEventCopyWith<$Res>  {
$BillsEventCopyWith(BillsEvent _, $Res Function(BillsEvent) __);
}


/// Adds pattern-matching-related methods to [BillsEvent].
extension BillsEventPatterns on BillsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadBills value)?  loadBills,TResult Function( CreateBill value)?  createBill,TResult Function( UpdateBillStatus value)?  updateBillStatus,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadBills() when loadBills != null:
return loadBills(_that);case CreateBill() when createBill != null:
return createBill(_that);case UpdateBillStatus() when updateBillStatus != null:
return updateBillStatus(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadBills value)  loadBills,required TResult Function( CreateBill value)  createBill,required TResult Function( UpdateBillStatus value)  updateBillStatus,}){
final _that = this;
switch (_that) {
case LoadBills():
return loadBills(_that);case CreateBill():
return createBill(_that);case UpdateBillStatus():
return updateBillStatus(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadBills value)?  loadBills,TResult? Function( CreateBill value)?  createBill,TResult? Function( UpdateBillStatus value)?  updateBillStatus,}){
final _that = this;
switch (_that) {
case LoadBills() when loadBills != null:
return loadBills(_that);case CreateBill() when createBill != null:
return createBill(_that);case UpdateBillStatus() when updateBillStatus != null:
return updateBillStatus(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadBills,TResult Function( Map<String, dynamic> billData)?  createBill,TResult Function( String billId,  String status,  String? reviewComments)?  updateBillStatus,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadBills() when loadBills != null:
return loadBills();case CreateBill() when createBill != null:
return createBill(_that.billData);case UpdateBillStatus() when updateBillStatus != null:
return updateBillStatus(_that.billId,_that.status,_that.reviewComments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadBills,required TResult Function( Map<String, dynamic> billData)  createBill,required TResult Function( String billId,  String status,  String? reviewComments)  updateBillStatus,}) {final _that = this;
switch (_that) {
case LoadBills():
return loadBills();case CreateBill():
return createBill(_that.billData);case UpdateBillStatus():
return updateBillStatus(_that.billId,_that.status,_that.reviewComments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadBills,TResult? Function( Map<String, dynamic> billData)?  createBill,TResult? Function( String billId,  String status,  String? reviewComments)?  updateBillStatus,}) {final _that = this;
switch (_that) {
case LoadBills() when loadBills != null:
return loadBills();case CreateBill() when createBill != null:
return createBill(_that.billData);case UpdateBillStatus() when updateBillStatus != null:
return updateBillStatus(_that.billId,_that.status,_that.reviewComments);case _:
  return null;

}
}

}

/// @nodoc


class LoadBills implements BillsEvent {
  const LoadBills();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadBills);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BillsEvent.loadBills()';
}


}




/// @nodoc


class CreateBill implements BillsEvent {
  const CreateBill(final  Map<String, dynamic> billData): _billData = billData;
  

 final  Map<String, dynamic> _billData;
 Map<String, dynamic> get billData {
  if (_billData is EqualUnmodifiableMapView) return _billData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_billData);
}


/// Create a copy of BillsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateBillCopyWith<CreateBill> get copyWith => _$CreateBillCopyWithImpl<CreateBill>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateBill&&const DeepCollectionEquality().equals(other._billData, _billData));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_billData));

@override
String toString() {
  return 'BillsEvent.createBill(billData: $billData)';
}


}

/// @nodoc
abstract mixin class $CreateBillCopyWith<$Res> implements $BillsEventCopyWith<$Res> {
  factory $CreateBillCopyWith(CreateBill value, $Res Function(CreateBill) _then) = _$CreateBillCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> billData
});




}
/// @nodoc
class _$CreateBillCopyWithImpl<$Res>
    implements $CreateBillCopyWith<$Res> {
  _$CreateBillCopyWithImpl(this._self, this._then);

  final CreateBill _self;
  final $Res Function(CreateBill) _then;

/// Create a copy of BillsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? billData = null,}) {
  return _then(CreateBill(
null == billData ? _self._billData : billData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

/// @nodoc


class UpdateBillStatus implements BillsEvent {
  const UpdateBillStatus(this.billId, this.status, {this.reviewComments});
  

 final  String billId;
 final  String status;
 final  String? reviewComments;

/// Create a copy of BillsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateBillStatusCopyWith<UpdateBillStatus> get copyWith => _$UpdateBillStatusCopyWithImpl<UpdateBillStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateBillStatus&&(identical(other.billId, billId) || other.billId == billId)&&(identical(other.status, status) || other.status == status)&&(identical(other.reviewComments, reviewComments) || other.reviewComments == reviewComments));
}


@override
int get hashCode => Object.hash(runtimeType,billId,status,reviewComments);

@override
String toString() {
  return 'BillsEvent.updateBillStatus(billId: $billId, status: $status, reviewComments: $reviewComments)';
}


}

/// @nodoc
abstract mixin class $UpdateBillStatusCopyWith<$Res> implements $BillsEventCopyWith<$Res> {
  factory $UpdateBillStatusCopyWith(UpdateBillStatus value, $Res Function(UpdateBillStatus) _then) = _$UpdateBillStatusCopyWithImpl;
@useResult
$Res call({
 String billId, String status, String? reviewComments
});




}
/// @nodoc
class _$UpdateBillStatusCopyWithImpl<$Res>
    implements $UpdateBillStatusCopyWith<$Res> {
  _$UpdateBillStatusCopyWithImpl(this._self, this._then);

  final UpdateBillStatus _self;
  final $Res Function(UpdateBillStatus) _then;

/// Create a copy of BillsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? billId = null,Object? status = null,Object? reviewComments = freezed,}) {
  return _then(UpdateBillStatus(
null == billId ? _self.billId : billId // ignore: cast_nullable_to_non_nullable
as String,null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,reviewComments: freezed == reviewComments ? _self.reviewComments : reviewComments // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
