part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {
  @override
  String toString() => 'Init Data';
}

class SearchLoading extends SearchState {
  @override
  String toString() => 'Loading Data';
}

class SearchSuccess extends SearchState {
  final List<SearchModel> result;
  SearchSuccess(this.result);

  @override
  String toString() => 'Success : {result : $result}';
}

class SearchFailed extends SearchState {
  final String error;

  SearchFailed(this.error);

  @override
  String toString() => 'Failed : {failed : $error}';
}
