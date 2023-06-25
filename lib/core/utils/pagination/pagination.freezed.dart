// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pagination.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PaginationRequest _$PaginationRequestFromJson(Map<String, dynamic> json) {
  return _PaginationRequest.fromJson(json);
}

/// @nodoc
mixin _$PaginationRequest {
  int get limit => throw _privateConstructorUsedError;
  int get offset => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaginationRequestCopyWith<PaginationRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginationRequestCopyWith<$Res> {
  factory $PaginationRequestCopyWith(
          PaginationRequest value, $Res Function(PaginationRequest) then) =
      _$PaginationRequestCopyWithImpl<$Res, PaginationRequest>;
  @useResult
  $Res call({int limit, int offset});
}

/// @nodoc
class _$PaginationRequestCopyWithImpl<$Res, $Val extends PaginationRequest>
    implements $PaginationRequestCopyWith<$Res> {
  _$PaginationRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? limit = null,
    Object? offset = null,
  }) {
    return _then(_value.copyWith(
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PaginationRequestCopyWith<$Res>
    implements $PaginationRequestCopyWith<$Res> {
  factory _$$_PaginationRequestCopyWith(_$_PaginationRequest value,
          $Res Function(_$_PaginationRequest) then) =
      __$$_PaginationRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int limit, int offset});
}

/// @nodoc
class __$$_PaginationRequestCopyWithImpl<$Res>
    extends _$PaginationRequestCopyWithImpl<$Res, _$_PaginationRequest>
    implements _$$_PaginationRequestCopyWith<$Res> {
  __$$_PaginationRequestCopyWithImpl(
      _$_PaginationRequest _value, $Res Function(_$_PaginationRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? limit = null,
    Object? offset = null,
  }) {
    return _then(_$_PaginationRequest(
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PaginationRequest implements _PaginationRequest {
  const _$_PaginationRequest({required this.limit, this.offset = 0});

  factory _$_PaginationRequest.fromJson(Map<String, dynamic> json) =>
      _$$_PaginationRequestFromJson(json);

  @override
  final int limit;
  @override
  @JsonKey()
  final int offset;

  @override
  String toString() {
    return 'PaginationRequest(limit: $limit, offset: $offset)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PaginationRequest &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.offset, offset) || other.offset == offset));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, limit, offset);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PaginationRequestCopyWith<_$_PaginationRequest> get copyWith =>
      __$$_PaginationRequestCopyWithImpl<_$_PaginationRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PaginationRequestToJson(
      this,
    );
  }
}

abstract class _PaginationRequest implements PaginationRequest {
  const factory _PaginationRequest(
      {required final int limit, final int offset}) = _$_PaginationRequest;

  factory _PaginationRequest.fromJson(Map<String, dynamic> json) =
      _$_PaginationRequest.fromJson;

  @override
  int get limit;
  @override
  int get offset;
  @override
  @JsonKey(ignore: true)
  _$$_PaginationRequestCopyWith<_$_PaginationRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
