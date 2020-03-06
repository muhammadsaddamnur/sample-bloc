part of 'infinite_scroll_bloc.dart';

@immutable
abstract class InfiniteScrollState {}

class InfiniteScrollInitial extends InfiniteScrollState {
  @override
  String toString() => 'init';
}

class InfiniteScrollLoading extends InfiniteScrollState {
  @override
  String toString() => 'Loading data';
}

class InfiniteScrollLoadingMore extends InfiniteScrollState {
  @override
  String toString() => 'Loading data';
}

class InfiniteScrollSuccess extends InfiniteScrollState {
  final List<InfiniteScrollModel> result;
  final bool isLoading;

  InfiniteScrollSuccess({this.result, this.isLoading});

  @override
  String toString() => 'success :  {result :$result}';
}

class InfiniteScrollFailed extends InfiniteScrollState {
  final String error;
  InfiniteScrollFailed(this.error);
  @override
  String toString() => 'failed : {failed : $error}';
}
