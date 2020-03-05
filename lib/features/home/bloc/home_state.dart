part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {
  @override
  String toString() => 'Init Data';
}

class HomeLoading extends HomeState {
  @override
  String toString() => 'Loading Data';
}

class HomeSuccess extends HomeState {
  final List<NotaModel> result;

  HomeSuccess(this.result);

  @override
  String toString() => 'Success : {result : $result}';
}

class HomeFailed extends HomeState {
  final String error;

  HomeFailed(this.error);

  @override
  String toString() => 'Failed : {failed : $error}';
}
