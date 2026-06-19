// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fund.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Fund {

 String get id; String get title; String get description; double get amountOfFund; String get urgencyLevel; String get date; String? get imagePath; String get status; User? get createdBy; User? get reviewedBy; String? get reviewComments; String? get createdAt; String? get updatedAt;
/// Create a copy of Fund
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FundCopyWith<Fund> get copyWith => _$FundCopyWithImpl<Fund>(this as Fund, _$identity);

  /// Serializes this Fund to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Fund&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.amountOfFund, amountOfFund) || other.amountOfFund == amountOfFund)&&(identical(other.urgencyLevel, urgencyLevel) || other.urgencyLevel == urgencyLevel)&&(identical(other.date, date) || other.date == date)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.reviewedBy, reviewedBy) || other.reviewedBy == reviewedBy)&&(identical(other.reviewComments, reviewComments) || other.reviewComments == reviewComments)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,amountOfFund,urgencyLevel,date,imagePath,status,createdBy,reviewedBy,reviewComments,createdAt,updatedAt);

@override
String toString() {
  return 'Fund(id: $id, title: $title, description: $description, amountOfFund: $amountOfFund, urgencyLevel: $urgencyLevel, date: $date, imagePath: $imagePath, status: $status, createdBy: $createdBy, reviewedBy: $reviewedBy, reviewComments: $reviewComments, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $FundCopyWith<$Res>  {
  factory $FundCopyWith(Fund value, $Res Function(Fund) _then) = _$FundCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, double amountOfFund, String urgencyLevel, String date, String? imagePath, String status, User? createdBy, User? reviewedBy, String? reviewComments, String? createdAt, String? updatedAt
});


$UserCopyWith<$Res>? get createdBy;$UserCopyWith<$Res>? get reviewedBy;

}
/// @nodoc
class _$FundCopyWithImpl<$Res>
    implements $FundCopyWith<$Res> {
  _$FundCopyWithImpl(this._self, this._then);

  final Fund _self;
  final $Res Function(Fund) _then;

/// Create a copy of Fund
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? amountOfFund = null,Object? urgencyLevel = null,Object? date = null,Object? imagePath = freezed,Object? status = null,Object? createdBy = freezed,Object? reviewedBy = freezed,Object? reviewComments = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,amountOfFund: null == amountOfFund ? _self.amountOfFund : amountOfFund // ignore: cast_nullable_to_non_nullable
as double,urgencyLevel: null == urgencyLevel ? _self.urgencyLevel : urgencyLevel // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as User?,reviewedBy: freezed == reviewedBy ? _self.reviewedBy : reviewedBy // ignore: cast_nullable_to_non_nullable
as User?,reviewComments: freezed == reviewComments ? _self.reviewComments : reviewComments // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of Fund
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
}/// Create a copy of Fund
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


/// Adds pattern-matching-related methods to [Fund].
extension FundPatterns on Fund {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Fund value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Fund() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Fund value)  $default,){
final _that = this;
switch (_that) {
case _Fund():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Fund value)?  $default,){
final _that = this;
switch (_that) {
case _Fund() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  double amountOfFund,  String urgencyLevel,  String date,  String? imagePath,  String status,  User? createdBy,  User? reviewedBy,  String? reviewComments,  String? createdAt,  String? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Fund() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.amountOfFund,_that.urgencyLevel,_that.date,_that.imagePath,_that.status,_that.createdBy,_that.reviewedBy,_that.reviewComments,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  double amountOfFund,  String urgencyLevel,  String date,  String? imagePath,  String status,  User? createdBy,  User? reviewedBy,  String? reviewComments,  String? createdAt,  String? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Fund():
return $default(_that.id,_that.title,_that.description,_that.amountOfFund,_that.urgencyLevel,_that.date,_that.imagePath,_that.status,_that.createdBy,_that.reviewedBy,_that.reviewComments,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  double amountOfFund,  String urgencyLevel,  String date,  String? imagePath,  String status,  User? createdBy,  User? reviewedBy,  String? reviewComments,  String? createdAt,  String? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Fund() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.amountOfFund,_that.urgencyLevel,_that.date,_that.imagePath,_that.status,_that.createdBy,_that.reviewedBy,_that.reviewComments,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Fund implements Fund {
  const _Fund({required this.id, required this.title, required this.description, required this.amountOfFund, required this.urgencyLevel, required this.date, this.imagePath, required this.status, this.createdBy, this.reviewedBy, this.reviewComments, this.createdAt, this.updatedAt});
  factory _Fund.fromJson(Map<String, dynamic> json) => _$FundFromJson(json);

@override final  String id;
@override final  String title;
@override final  String description;
@override final  double amountOfFund;
@override final  String urgencyLevel;
@override final  String date;
@override final  String? imagePath;
@override final  String status;
@override final  User? createdBy;
@override final  User? reviewedBy;
@override final  String? reviewComments;
@override final  String? createdAt;
@override final  String? updatedAt;

/// Create a copy of Fund
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FundCopyWith<_Fund> get copyWith => __$FundCopyWithImpl<_Fund>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FundToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Fund&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.amountOfFund, amountOfFund) || other.amountOfFund == amountOfFund)&&(identical(other.urgencyLevel, urgencyLevel) || other.urgencyLevel == urgencyLevel)&&(identical(other.date, date) || other.date == date)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.reviewedBy, reviewedBy) || other.reviewedBy == reviewedBy)&&(identical(other.reviewComments, reviewComments) || other.reviewComments == reviewComments)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,amountOfFund,urgencyLevel,date,imagePath,status,createdBy,reviewedBy,reviewComments,createdAt,updatedAt);

@override
String toString() {
  return 'Fund(id: $id, title: $title, description: $description, amountOfFund: $amountOfFund, urgencyLevel: $urgencyLevel, date: $date, imagePath: $imagePath, status: $status, createdBy: $createdBy, reviewedBy: $reviewedBy, reviewComments: $reviewComments, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$FundCopyWith<$Res> implements $FundCopyWith<$Res> {
  factory _$FundCopyWith(_Fund value, $Res Function(_Fund) _then) = __$FundCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, double amountOfFund, String urgencyLevel, String date, String? imagePath, String status, User? createdBy, User? reviewedBy, String? reviewComments, String? createdAt, String? updatedAt
});


@override $UserCopyWith<$Res>? get createdBy;@override $UserCopyWith<$Res>? get reviewedBy;

}
/// @nodoc
class __$FundCopyWithImpl<$Res>
    implements _$FundCopyWith<$Res> {
  __$FundCopyWithImpl(this._self, this._then);

  final _Fund _self;
  final $Res Function(_Fund) _then;

/// Create a copy of Fund
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? amountOfFund = null,Object? urgencyLevel = null,Object? date = null,Object? imagePath = freezed,Object? status = null,Object? createdBy = freezed,Object? reviewedBy = freezed,Object? reviewComments = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_Fund(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,amountOfFund: null == amountOfFund ? _self.amountOfFund : amountOfFund // ignore: cast_nullable_to_non_nullable
as double,urgencyLevel: null == urgencyLevel ? _self.urgencyLevel : urgencyLevel // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as User?,reviewedBy: freezed == reviewedBy ? _self.reviewedBy : reviewedBy // ignore: cast_nullable_to_non_nullable
as User?,reviewComments: freezed == reviewComments ? _self.reviewComments : reviewComments // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of Fund
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
}/// Create a copy of Fund
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
