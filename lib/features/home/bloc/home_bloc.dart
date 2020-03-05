import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:samplebloc/core/services/api_services.dart';
import 'package:samplebloc/features/home/model/nota_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => HomeInitial();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is GetNota) {
      yield* _loadData();
    } else if (event is GetBiji) {
      yield HomeFailed('wkwkwk');
    }
  }
}

Stream<HomeState> _loadData() async* {
  ResponseModel response =
      await ApiServices.request(methodRequest: MethodRequest.get, endpoint: 'posts');
  List<NotaModel> data;
  yield HomeLoading();
  if (response != null) {
    data = await compute(notaModelFromJson, response.response.toString());
    if (response.statusCode == 200) {
      yield HomeSuccess(data);
    } else {
      yield HomeFailed('Error Nih Kampret');
    }
  } else {
    yield HomeFailed('Error Nih Kampret');
  }
}
