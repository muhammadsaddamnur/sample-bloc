import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:samplebloc/core/services/api_services.dart';
import 'package:samplebloc/features/search/model/search_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  @override
  SearchState get initialState => SearchInitial();

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is Search) {
      yield* _loadData(userId: event.userId);
    } else if (event is GetBiji) {
      yield SearchFailed('');
    }
  }

  Stream<SearchState> _loadData({userId}) async* {
    yield SearchLoading();
    ResponseModel response = await ApiServices.request(
        methodRequest: MethodRequest.get, endpoint: 'posts?userId=$userId');
    List<SearchModel> data;

    if (response != null) {
      data = await compute(searchModelFromJson, response.response.toString());
      if (response.statusCode == 200) {
        yield SearchSuccess(data);
      } else {
        yield SearchFailed('Error Nih Kampret');
      }
    } else {
      yield SearchFailed('Error Nih Kampret');
    }
  }
}
