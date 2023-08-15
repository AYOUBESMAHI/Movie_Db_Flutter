part of 'search_bloc.dart';

abstract class SearchEvent {
  const SearchEvent();

  dynamic get props => "";
}

class FetchSeriesMovies extends SearchEvent {
  final String querry;
  final int page;
  FetchSeriesMovies(this.querry, this.page);
}

class ResetSearchMovies extends SearchEvent {}
