// 📦 Package imports:
import 'package:dartz/dartz.dart';
import 'package:tech_test/core/utils/failure/failure.dart';

// 🌎 Project imports:

import 'package:tech_test/core/utils/pagination/pagination.dart';

/// Pagination을 수행할 때, 한번에 가지고 올 리스트의 개수입니다.
typedef Limit = int;
typedef Offset = int;

/// [PaginationInterface]는 페이지네이션을 손쉽게 호출 할 수 있도록 구현되었습니다.
/// [paginate]함수를 통해 페이지네이션을 사용한 fetch를 수행할 수 있습니다.
/// - [previousPState] : 이전 페이지네이션 상태를 값으로 받습니다
/// - [onPaginationStateChange] : 페이지네이션 상태가 바뀔때마다 호출되는 함수를 인자로 받습니다.
/// - [fetchDataFunction] : 데이터를 가지고 올 통신 함수를 인자로 받습니다.
///                         Cursor정보와 PageLimit을 리턴해주고, 이를 사용하여 바깥에서 통신을 수행할 수 있습니다.
/// - [fetchLimit] : 한번에 몇개의 리스트를 불러올지 지정합니다.
/// - [fetchMore] : 페이지네이션을 통해 기존 데이터에 이어 더 불러오는지 판단하는 인자입니다.
/// - [forceRefetch] : 리프래쉬하거나, 검색어가 바뀔때마다 새롭게 데이터를 불러올지 판단하는 인자입니다.
class PaginationInterface {
  static Future<void> paginate<T>({
    required PaginationBase previousPState,
    required Function(PaginationBase<T>) onPaginationStateChange,
    required Future<Either<Failure, PaginationBase<T>>> Function(
      PaginationRequest,
    ) fetchDataFunction,
    Limit fetchLimit = 20,
    bool fetchMore = false,
    bool forceRefetch = false,
  }) async {
    // 1. PaginationResponse상태(통신에 성공하여 데이터를 가지고 있는 상태)이고,
    // 2. 강제로 데이터를 다시 가져와야 하는 경우가 아니며,
    // 3. 서버에서 마지막 데이터라는 응답을 받았던 경우 통신을 수행하지 않고 리턴합니다.
    if (previousPState is PaginationResponse && !forceRefetch) {
      bool pageEnded = !(previousPState as PaginationResponse<T>).hasNextPage;
      if (pageEnded) {
        return;
      }
    }

    // 스크롤을 감지하여 Pagination이 이미 수행되고 있을 경우에
    // 스크롤이 변경될때마다 불필요한 API요청이 반복되지 않도록 lock 합니다.
    final isLoading = previousPState is PaginationLoading;
    final isRefetching = previousPState is PaginationRefetching;
    final isFetchingMore = previousPState is PaginationFetchingMore;

    if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
      // scrollController를 통해 fetchMore이 수행되었을 때
      // 이미 통신이 진행중인 경우 lock합니다.
      return;
    }

    // 현재 가지고 있는 데이터가 있고, 강제로 데이터를 다시 불러오는 경우가 아니라면
    // 다음 데이터를 불러오기 위해 다음 cursor의 정보를 저장합니다.
    PaginationRequest paginationRequest = PaginationRequest(limit: fetchLimit);

    // 위의 조건들을 통과했다면, scrollController를 통한 통신 요청인지 판단합니다.
    if (fetchMore) {
      final pState = previousPState as PaginationResponse<T>;
      // scrollController를 통한 통신 요청이라면, PaginationFetchingMore상태로 변경합니다.

      previousPState = PaginationFetchingMore<T>(
        items: pState.items,
        paginationRequest: pState.paginationRequest,
        hasNextPage: pState.hasNextPage,
      );
      onPaginationStateChange.call(previousPState);
      paginationRequest = paginationRequest.copyWith(
          offset: previousPState.paginationRequest.offset);
    } else {
      // scrollController를 통한 통신 요청이 아니고, 데이터가 있는 상황이라면
      // PaginationRefetching 상태로 변경하여 데이터를 보존한 상태에서 API 요청
      if (previousPState is PaginationResponse<T> && !forceRefetch) {
        final pState = previousPState;

        previousPState = PaginationRefetching<T>(
          items: pState.items,
          paginationRequest: pState.paginationRequest,
          hasNextPage: pState.hasNextPage,
        );
        onPaginationStateChange.call(previousPState);
      } else {
        previousPState = PaginationLoading();
        onPaginationStateChange.call(PaginationLoading());
      }
    }

    // 인자로 받은 데이터를 가지고 오는 function을 수행합니다.
    // function을 수행할 때, 세팅된 cursorInfo와 fetchLimit 값을 넘깁니다.
    final dataEither = await fetchDataFunction.call(paginationRequest);

    final PaginationBase<T> newPstate = dataEither.fold(
      (failure) => PaginationError<T>(message: failure.message),
      (result) => result,
    );

    // 결과를 불러오는 데에 성공했고, PaginationFetchingMore상태라면
    // 기존에 있는 리스트 뒤에 새로 불러온 리스트를 추가합니다.
    if (previousPState is PaginationFetchingMore<T>) {
      final pState = previousPState;

      if (newPstate is PaginationResponse<T>) {
        onPaginationStateChange.call(
          PaginationResponse(
            items: [
              ...pState.items,
              ...newPstate.items,
            ],
            paginationRequest: newPstate.paginationRequest,
            hasNextPage: newPstate.items.isNotEmpty,
          ),
        );
      } else if (newPstate is PaginationError) {
        // 만약에 FetchingMore상태인데 에러가 날라오면 hasNextPage를 false로 바꿔주고 리스트는 그대로 유지한다.
        onPaginationStateChange.call(
          PaginationResponse(
            items: pState.items,
            paginationRequest: pState.paginationRequest,
            hasNextPage: false,
          ),
        );
      } else {
        onPaginationStateChange.call(pState);
      }
    } else {
      onPaginationStateChange.call(newPstate);
    }
  }
}
