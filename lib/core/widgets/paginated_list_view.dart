import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tech_test/core/utils/pagination/pagination.dart';

typedef Index = int;

// 설탭에서 사용되는 pagination을 위한 리스트 위젯
// T에 표시하기를 원하는 데이터의 클래스를 넣으면, PaginationResponse일 경우에 successBuilder를 통해 데이터를 반환합니다.
// 해당 데이터를 받아 원하는 위젯에 원하는 형태로 반영할 수 있습니다.
class PaginatedListView<T> extends StatefulWidget {
  final PaginationBase<T> state;
  final Widget Function(T, Index) successBuilder;
  final Function() onEndOfPage;
  final Widget Function(BuildContext, int)? separatorBuilder;
  final Future<void> Function()? onRefresh;

  const PaginatedListView({
    Key? key,
    required this.state,
    required this.successBuilder,
    required this.onEndOfPage,
    this.separatorBuilder,
    this.onRefresh,
  }) : super(key: key);

  @override
  State<PaginatedListView<T>> createState() => _PaginatedListViewState<T>();
}

class _PaginatedListViewState<T> extends State<PaginatedListView<T>> {
  final ScrollController _paginatedScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _paginatedScrollController.addListener(() {
      if (_paginatedScrollController.offset >
          _paginatedScrollController.position.maxScrollExtent - 200) {
        widget.onEndOfPage.call();
      }
    });
  }

  @override
  void dispose() {
    _paginatedScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.state is PaginationLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
        ),
      );
    }

    if (widget.state is PaginationError) {
      final error = widget.state as PaginationError;

      if (kDebugMode) {
        log(error.message);
      }

      return const SizedBox.shrink();
    }

    final data = widget.state as PaginationResponse;
    return RefreshIndicator(
      onRefresh: widget.onRefresh ?? () async {},
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        controller: _paginatedScrollController,
        itemCount: data.items.length + 1,
        itemBuilder: (context, index) {
          if (index == data.items.length) {
            return (data is PaginationFetchingMore)
                ? Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: const Center(
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink();
          }
          if (data.items[index] is T) {
            final item = data.items[index] as T;

            return widget.successBuilder(item, index);
          }

          return const SizedBox.shrink();
        },
        separatorBuilder: widget.separatorBuilder ??
            (BuildContext context, int index) {
              return const SizedBox(height: 20);
            },
      ),
    );
  }
}
