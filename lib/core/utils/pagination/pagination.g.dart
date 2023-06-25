// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationResponse<T> _$PaginationResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    PaginationResponse<T>(
      items: (json['items'] as List<dynamic>).map(fromJsonT).toList(),
      paginationRequest: PaginationRequest.fromJson(
          json['paginationRequest'] as Map<String, dynamic>),
      hasNextPage: json['hasNextPage'] as bool,
    );

Map<String, dynamic> _$PaginationResponseToJson<T>(
  PaginationResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'items': instance.items.map(toJsonT).toList(),
      'paginationRequest': instance.paginationRequest,
      'hasNextPage': instance.hasNextPage,
    };

_$_PaginationRequest _$$_PaginationRequestFromJson(Map<String, dynamic> json) =>
    _$_PaginationRequest(
      limit: json['limit'] as int,
      offset: json['offset'] as int? ?? 0,
    );

Map<String, dynamic> _$$_PaginationRequestToJson(
        _$_PaginationRequest instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'offset': instance.offset,
    };
