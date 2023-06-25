import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination.g.dart';
part 'pagination.freezed.dart';

// 페이지네이션이 필요한 모든 데이터의 베이스가 되는 abstract class
abstract class PaginationBase<T> {}

// 페이지네이션 에러 상태
class PaginationError<T> implements PaginationBase<T> {
  final String message;
  PaginationError({required this.message});
}

// 페이지네이션 로딩 상태(아무런 데이터가 없는 상태에서 로딩만 하는 상태입니다)
// 이는 PaginationFetchingMore과 달리, scroll 액션과 관련되어있지 않습니다.
class PaginationLoading<T> implements PaginationBase<T> {}

// scroll을 통해 Pagination을 수행하여 추가적 데이터를 불러오는 상태
// PaginationFetchingMore는 PaginationResponse를 상속하고 있습니다.
// 이는 해당 상태가 데이터를 가지고 있기 때문입니다.
class PaginationFetchingMore<T> implements PaginationResponse<T> {
  PaginationFetchingMore(
      {required this.items,
      required this.paginationRequest,
      required this.hasNextPage});

  @override
  final List<T> items;

  @override
  final PaginationRequest paginationRequest;

  @override
  final bool hasNextPage;

  @override
  PaginationFetchingMore copyWith({
    List<T>? items,
    PaginationRequest? paginationRequest,
    bool? hasNextPage,
  }) {
    return PaginationFetchingMore(
      items: items ?? this.items,
      paginationRequest: paginationRequest ?? this.paginationRequest,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }
}

// 새로운 데이터를 다시 가지고 오는 상태
// PaginationRefetching는 PaginationResponse를 상속하고 있습니다.
// 이는 해당 상태가 데이터를 가지고 있기 때문입니다.
class PaginationRefetching<T> implements PaginationResponse<T> {
  PaginationRefetching(
      {required this.items,
      required this.paginationRequest,
      required this.hasNextPage});

  @override
  final List<T> items;

  @override
  final PaginationRequest paginationRequest;

  @override
  final bool hasNextPage;

  @override
  PaginationRefetching copyWith({
    List<T>? items,
    PaginationRequest? paginationRequest,
    bool? hasNextPage,
  }) {
    return PaginationRefetching(
      items: items ?? this.items,
      paginationRequest: paginationRequest ?? this.paginationRequest,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }
}

// PaginationResponse는 결과값을 가지고 있는 모든 pagination의 부모가 됩니다.
// PaginationRefetching, PaginationFetchingMore는 해당 클래스를 상속받고 있습니다.
// PaginationResponse는 PaginationBase를 구현하고 있습니다.
// JsonSerializable의 genericArgumentFactories를 사용하였으므로,
// T에 원하는 dto를 넣어 pagination이 필요한 모든 곳에서 자동 파싱하여 사용할 수 있습니다.

@JsonSerializable(genericArgumentFactories: true)
class PaginationResponse<T> implements PaginationBase<T> {
  final List<T> items;
  final PaginationRequest paginationRequest;
  final bool hasNextPage;

  PaginationResponse({
    required this.items,
    required this.paginationRequest,
    required this.hasNextPage,
  });

  factory PaginationResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PaginationResponseFromJson(json, fromJsonT);

  PaginationResponse copyWith({
    List<T>? items,
    PaginationRequest? paginationRequest,
    bool? hasNextPage,
  }) {
    return PaginationResponse(
      items: items ?? this.items,
      paginationRequest: paginationRequest ?? this.paginationRequest,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }
}

@freezed
class PaginationRequest with _$PaginationRequest {
  const factory PaginationRequest(
      {required int limit, @Default(0) int offset}) = _PaginationRequest;

  factory PaginationRequest.fromJson(Map<String, dynamic> json) =>
      _$PaginationRequestFromJson(json);
}
