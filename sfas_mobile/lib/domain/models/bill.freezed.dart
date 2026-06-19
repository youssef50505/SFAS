// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bill.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Bill {

 String get id; String get title; Vendor? get vendor; double get amount; double get tax; String get date; String? get imagePath; String get description; String get status; User? get createdBy; User? get reviewedBy; String? get reviewComments; String? get createdAt; String? get updatedAt;
/// Create a copy of Bill
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillCopyWith<Bill> get copyWith => _$BillCopyWithImpl<Bill>(this as Bill, _$identity);

  /// Serializes this Bill to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Bill&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.vendor, vendor) || other.vendor == vendor)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.tax, tax) || other.tax == tax)&&(identical(other.date, date) || other.date == date)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.reviewedBy, reviewedBy) || other.reviewedBy == reviewedBy)&&(identical(other.reviewComments, reviewComments) || other.reviewComments == reviewComments)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,vendor,amount,tax,date,imagePath,description,status,createdBy,reviewedBy,reviewComments,createdAt,updatedAt);

@override
String toString() {
  return 'Bill(id: $id, title: $title, vendor: $vendor, amount: $amount, tax: $tax, date: $date, imagePath: $imagePath, description: $description, status: $status, createdBy: $createdBy, reviewedBy: $reviewedBy, reviewComments: $reviewComments, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $BillCopyWith<$Res>  {
  factory $BillCopyWith(Bill value, $Res Function(Bill) _then) = _$BillCopyWithImpl;
@useResult
$Res call({
 String id, String title, Vendor? vendor, double amount, double tax, String date, String? imagePath, String description, String status, User? createdBy, User? reviewedBy, String? reviewComments, String? createdAt, String? updatedAt
});


$VendorCopyWith<$Res>? get vendor;$UserCopyWith<$Res>? get createdBy;$UserCopyWith<$Res>? get reviewedBy;

}
/// @nodoc
class _$BillCopyWithImpl<$Res>
    implements $BillCopyWith<$Res> {
  _$BillCopyWithImpl(this._self, this._then);

  final Bill _self;
  final $Res Function(Bill) _then;

/// Create a copy of Bill
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? vendor = freezed,Object? amount = null,Object? tax = null,Object? date = null,Object? imagePath = freezed,Object? description = null,Object? status = null,Object? createdBy = freezed,Object? reviewedBy = freezed,Object? reviewComments = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,vendor: freezed == vendor ? _self.vendor : vendor // ignore: cast_nullable_to_non_nullable
as Vendor?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,tax: null == tax ? _self.tax : tax // ignore: cast_nullable_to_non_nullable
as double,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as User?,reviewedBy: freezed == reviewedBy ? _self.reviewedBy : reviewedBy // ignore: cast_nullable_to_non_nullable
as User?,reviewComments: freezed == reviewComments ? _self.reviewComments : reviewComments // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of Bill
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VendorCopyWith<$Res>? get vendor {
    if (_self.vendor == null) {
    return null;
  }

  return $VendorCopyWith<$Res>(_self.vendor!, (value) {
    return _then(_self.copyWith(vendor: value));
  });
}/// Create a copy of Bill
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res>? get createdBy {
    if (_self.createdBy == null) {
    return null;
  }

  return $UserCopyWith<$Res>(_self.createdBy!, (value) {
    return _then(_self.copyWith(createdBy: value));
  });
}/// Create a copy of Bill
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res>? get reviewedBy {
    if (_self.reviewedBy == null) {
    return null;
  }

  return $UserCopyWith<$Res>(_self.reviewedBy!, (value) {
    return _then(_self.copyWith(reviewedBy: value));
  });
}
}


/// Adds pattern-matching-related methods to [Bill].
extension BillPatterns on Bill {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Bill value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Bill() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Bill value)  $default,){
final _that = this;
switch (_that) {
case _Bill():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Bill value)?  $default,){
final _that = this;
switch (_that) {
case _Bill() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  Vendor? vendor,  double amount,  double tax,  String date,  String? imagePath,  String description,  String status,  User? createdBy,  User? reviewedBy,  String? reviewComments,  String? createdAt,  String? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Bill() when $default != null:
return $default(_that.id,_that.title,_that.vendor,_that.amount,_that.tax,_that.date,_that.imagePath,_that.description,_that.status,_that.createdBy,_that.reviewedBy,_that.reviewComments,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  Vendor? vendor,  double amount,  double tax,  String date,  String? imagePath,  String description,  String status,  User? createdBy,  User? reviewedBy,  String? reviewComments,  String? createdAt,  String? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Bill():
return $default(_that.id,_that.title,_that.vendor,_that.amount,_that.tax,_that.date,_that.imagePath,_that.description,_that.status,_that.createdBy,_that.reviewedBy,_that.reviewComments,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  Vendor? vendor,  double amount,  double tax,  String date,  String? imagePath,  String description,  String status,  User? createdBy,  User? reviewedBy,  String? reviewComments,  String? createdAt,  String? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Bill() when $default != null:
return $default(_that.id,_that.title,_that.vendor,_that.amount,_that.tax,_that.date,_that.imagePath,_that.description,_that.status,_that.createdBy,_that.reviewedBy,_that.reviewComments,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Bill implements Bill {
  const _Bill({required this.id, required this.title, this.vendor, required this.amount, required this.tax, required this.date, this.imagePath, required this.description, required this.status, this.createdBy, this.reviewedBy, this.reviewComments, this.createdAt, this.updatedAt});
  factory _Bill.fromJson(Map<String, dynamic> json) => _$BillFromJson(json);

@override final  String id;
@override final  String title;
@override final  Vendor? vendor;
@override final  double amount;
@override final  double tax;
@override final  String date;
@override final  String? imagePath;
@override final  String description;
@override final  String status;
@override final  User? createdBy;
@override final  User? reviewedBy;
@override final  String? reviewComments;
@override final  String? createdAt;
@override final  String? updatedAt;

/// Create a copy of Bill
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BillCopyWith<_Bill> get copyWith => __$BillCopyWithImpl<_Bill>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BillToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Bill&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.vendor, vendor) || other.vendor == vendor)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.tax, tax) || other.tax == tax)&&(identical(other.date, date) || other.date == date)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.reviewedBy, reviewedBy) || other.reviewedBy == reviewedBy)&&(identical(other.reviewComments, reviewComments) || other.reviewComments == reviewComments)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,vendor,amount,tax,date,imagePath,description,status,createdBy,reviewedBy,reviewComments,createdAt,updatedAt);

@override
String toString() {
  return 'Bill(id: $id, title: $title, vendor: $vendor, amount: $amount, tax: $tax, date: $date, imagePath: $imagePath, description: $description, status: $status, createdBy: $createdBy, reviewedBy: $reviewedBy, reviewComments: $reviewComments, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$BillCopyWith<$Res> implements $BillCopyWith<$Res> {
  factory _$BillCopyWith(_Bill value, $Res Function(_Bill) _then) = __$BillCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, Vendor? vendor, double amount, double tax, String date, String? imagePath, String description, String status, User? createdBy, User? reviewedBy, String? reviewComments, String? createdAt, String? updatedAt
});


@override $VendorCopyWith<$Res>? get vendor;@override $UserCopyWith<$Res>? get createdBy;@override $UserCopyWith<$Res>? get reviewedBy;

}
/// @nodoc
class __$BillCopyWithImpl<$Res>
    implements _$BillCopyWith<$Res> {
  __$BillCopyWithImpl(this._self, this._then);

  final _Bill _self;
  final $Res Function(_Bill) _then;

/// Create a copy of Bill
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? vendor = freezed,Object? amount = null,Object? tax = null,Object? date = null,Object? imagePath = freezed,Object? description = null,Object? status = null,Object? createdBy = freezed,Object? reviewedBy = freezed,Object? reviewComments = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_Bill(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,vendor: freezed == vendor ? _self.vendor : vendor // ignore: cast_nullable_to_non_nullable
as Vendor?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,tax: null == tax ? _self.tax : tax // ignore: cast_nullable_to_non_nullable
as double,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as User?,reviewedBy: freezed == reviewedBy ? _self.reviewedBy : reviewedBy // ignore: cast_nullable_to_non_nullable
as User?,reviewComments: freezed == reviewComments ? _self.reviewComments : reviewComments // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of Bill
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VendorCopyWith<$Res>? get vendor {
    if (_self.vendor == null) {
    return null;
  }

  return $VendorCopyWith<$Res>(_self.vendor!, (value) {
    return _then(_self.copyWith(vendor: value));
  });
}/// Create a copy of Bill
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res>? get createdBy {
    if (_self.createdBy == null) {
    return null;
  }

  return $UserCopyWith<$Res>(_self.createdBy!, (value) {
    return _then(_self.copyWith(createdBy: value));
  });
}/// Create a copy of Bill
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res>? get reviewedBy {
    if (_self.reviewedBy == null) {
    return null;
  }

  return $UserCopyWith<$Res>(_self.reviewedBy!, (value) {
    return _then(_self.copyWith(reviewedBy: value));
  });
}
}

// dart format on
