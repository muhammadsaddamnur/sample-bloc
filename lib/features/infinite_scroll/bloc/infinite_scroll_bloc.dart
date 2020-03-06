import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:samplebloc/core/services/api_services.dart';
import 'package:samplebloc/features/infinite_scroll/model/infinite_scroll_model.dart';

part 'infinite_scroll_event.dart';
part 'infinite_scroll_state.dart';

class InfiniteScrollBloc
    extends Bloc<InfiniteScrollEvent, InfiniteScrollState> {
  @override
  InfiniteScrollState get initialState => InfiniteScrollInitial();

  @override
  Stream<InfiniteScrollState> mapEventToState(
    InfiniteScrollEvent event,
  ) async* {
    final currentState = state;
    if (event is PullScroll) {
      if (state is InfiniteScrollInitial) {
        yield* _loadData(start: 0);
      } else if (currentState is InfiniteScrollSuccess) {
        yield* _loadData(start: currentState.result.length);
      }
    }
  }

  Stream<InfiniteScrollState> _loadData({start}) async* {
    ResponseModel response = await ApiServices.request(
        methodRequest: MethodRequest.get,
        endpoint: 'posts?_start=${start.toString()}&_limit=20');
    List<InfiniteScrollModel> data;
    yield InfiniteScrollLoading();
    if (response != null) {
      data = await compute(
          infiniteScrollModelFromJson, response.response.toString());
      if (response.statusCode == 200) {
        yield InfiniteScrollSuccess(data);
      } else {
        yield InfiniteScrollFailed('Error Nih Kampret');
      }
    } else {
      yield InfiniteScrollFailed('Error Nih Kampret');
    }
  }
}
