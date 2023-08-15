part of 'search_bloc.dart';

abstract class SearchState {
  const SearchState();

  dynamic get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchError extends SearchState {}

class SearchLoaded extends SearchState {
  final Map<String, dynamic> searched;
  SearchLoaded(this.searched);

  @override
  Map<String, dynamic> get props => {...searched};
}
