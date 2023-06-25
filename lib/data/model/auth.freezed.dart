// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Authentication _$AuthenticationFromJson(Map<String, dynamic> json) {
  return _Authentication.fromJson(json);
}

/// @nodoc
mixin _$Authentication {
  @HiveField(0)
  String get token => throw _privateConstructorUsedError;
  @HiveField(1)
  DateTime get expiredDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthenticationCopyWith<Authentication> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticationCopyWith<$Res> {
  factory $AuthenticationCopyWith(
          Authentication value, $Res Function(Authentication) then) =
      _$AuthenticationCopyWithImpl<$Res, Authentication>;
  @useResult
  $Res call({@HiveField(0) String token, @HiveField(1) DateTime expiredDate});
}

/// @nodoc
class _$AuthenticationCopyWithImpl<$Res, $Val extends Authentication>
    implements $AuthenticationCopyWith<$Res> {
  _$AuthenticationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? expiredDate = null,
  }) {
    return _then(_value.copyWith(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      expiredDate: null == expiredDate
          ? _value.expiredDate
          : expiredDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AuthenticationCopyWith<$Res>
    implements $AuthenticationCopyWith<$Res> {
  factory _$$_AuthenticationCopyWith(
          _$_Authentication value, $Res Function(_$_Authentication) then) =
      __$$_AuthenticationCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@HiveField(0) String token, @HiveField(1) DateTime expiredDate});
}

/// @nodoc
class __$$_AuthenticationCopyWithImpl<$Res>
    extends _$AuthenticationCopyWithImpl<$Res, _$_Authentication>
    implements _$$_AuthenticationCopyWith<$Res> {
  __$$_AuthenticationCopyWithImpl(
      _$_Authentication _value, $Res Function(_$_Authentication) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? expiredDate = null,
  }) {
    return _then(_$_Authentication(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      expiredDate: null == expiredDate
          ? _value.expiredDate
          : expiredDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 2)
class _$_Authentication extends _Authentication {
  const _$_Authentication(
      {@HiveField(0) required this.token,
      @HiveField(1) required this.expiredDate})
      : super._();

  factory _$_Authentication.fromJson(Map<String, dynamic> json) =>
      _$$_AuthenticationFromJson(json);

  @override
  @HiveField(0)
  final String token;
  @override
  @HiveField(1)
  final DateTime expiredDate;

  @override
  String toString() {
    return 'Authentication(token: $token, expiredDate: $expiredDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Authentication &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.expiredDate, expiredDate) ||
                other.expiredDate == expiredDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, token, expiredDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthenticationCopyWith<_$_Authentication> get copyWith =>
      __$$_AuthenticationCopyWithImpl<_$_Authentication>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AuthenticationToJson(
      this,
    );
  }
}

abstract class _Authentication extends Authentication {
  const factory _Authentication(
      {@HiveField(0) required final String token,
      @HiveField(1) required final DateTime expiredDate}) = _$_Authentication;
  const _Authentication._() : super._();

  factory _Authentication.fromJson(Map<String, dynamic> json) =
      _$_Authentication.fromJson;

  @override
  @HiveField(0)
  String get token;
  @override
  @HiveField(1)
  DateTime get expiredDate;
  @override
  @JsonKey(ignore: true)
  _$$_AuthenticationCopyWith<_$_Authentication> get copyWith =>
      throw _privateConstructorUsedError;
}
