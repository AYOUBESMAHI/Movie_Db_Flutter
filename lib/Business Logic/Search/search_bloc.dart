import 'package:bloc/bloc.dart';

import 'package:moviedb/Data/Reposetories/SearchRepository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<FetchSeriesMovies>(_fetchMoviesSeries);
    on<ResetSearchMovies>(_resetSearch);
  }

  void _fetchMoviesSeries(
      FetchSeriesMovies event, Emitter<SearchState> emit) async {
    emit(SearchLoading());
    try {
      final result =
          await SearchRepository().getSearched(event.querry, event.page);
      emit(SearchLoaded(result));
    } catch (error) {
      print("_fetchTvSeries Error => $error");
      emit(SearchError());
    }
  }

  void _resetSearch(ResetSearchMovies event, Emitter<SearchState> emit) {
    emit(SearchLoaded({}));

    emit(SearchInitial());
  }
}
