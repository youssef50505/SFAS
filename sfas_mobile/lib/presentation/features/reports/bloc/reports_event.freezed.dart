// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reports_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReportsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReportsEvent()';
}


}

/// @nodoc
class $ReportsEventCopyWith<$Res>  {
$ReportsEventCopyWith(ReportsEvent _, $Res Function(ReportsEvent) __);
}


/// Adds pattern-matching-related methods to [ReportsEvent].
extension ReportsEventPatterns on ReportsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadReports value)?  loadReports,TResult Function( CreateReport value)?  createReport,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadReports() when loadReports != null:
return loadReports(_that);case CreateReport() when createReport != null:
return createReport(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadReports value)  loadReports,required TResult Function( CreateReport value)  createReport,}){
final _that = this;
switch (_that) {
case LoadReports():
return loadReports(_that);case CreateReport():
return createReport(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadReports value)?  loadReports,TResult? Function( CreateReport value)?  createReport,}){
final _that = this;
switch (_that) {
case LoadReports() when loadReports != null:
return loadReports(_that);case CreateReport() when createReport != null:
return createReport(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadReports,TResult Function( Map<String, dynamic> reportData)?  createReport,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadReports() when loadReports != null:
return loadReports();case CreateReport() when createReport != null:
return createReport(_that.reportData);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadReports,required TResult Function( Map<String, dynamic> reportData)  createReport,}) {final _that = this;
switch (_that) {
case LoadReports():
return loadReports();case CreateReport():
return createReport(_that.reportData);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadReports,TResult? Function( Map<String, dynamic> reportData)?  createReport,}) {final _that = this;
switch (_that) {
case LoadReports() when loadReports != null:
return loadReports();case CreateReport() when createReport != null:
return createReport(_that.reportData);case _:
  return null;

}
}

}

/// @nodoc


class LoadReports implements ReportsEvent {
  const LoadReports();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadReports);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReportsEvent.loadReports()';
}


}




/// @nodoc


class CreateReport implements ReportsEvent {
  const CreateReport(final  Map<String, dynamic> reportData): _reportData = reportData;
  

 final  Map<String, dynamic> _reportData;
 Map<String, dynamic> get reportData {
  if (_reportData is EqualUnmodifiableMapView) return _reportData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_reportData);
}


/// Create a copy of ReportsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateReportCopyWith<CreateReport> get copyWith => _$CreateReportCopyWithImpl<CreateReport>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateReport&&const DeepCollectionEquality().equals(other._reportData, _reportData));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_reportData));

@override
String toString() {
  return 'ReportsEvent.createReport(reportData: $reportData)';
}


}

/// @nodoc
abstract mixin class $CreateReportCopyWith<$Res> implements $ReportsEventCopyWith<$Res> {
  factory $CreateReportCopyWith(CreateReport value, $Res Function(CreateReport) _then) = _$CreateReportCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> reportData
});




}
/// @nodoc
class _$CreateReportCopyWithImpl<$Res>
    implements $CreateReportCopyWith<$Res> {
  _$CreateReportCopyWithImpl(this._self, this._then);

  final CreateReport _self;
  final $Res Function(CreateReport) _then;

/// Create a copy of ReportsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reportData = null,}) {
  return _then(CreateReport(
null == reportData ? _self._reportData : reportData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
