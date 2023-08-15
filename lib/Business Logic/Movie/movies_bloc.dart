import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moviedb/Constants/Strings.dart';

import 'package:moviedb/Data/Models/Genre.dart';
import 'package:moviedb/Data/Models/Movie.dart';
import 'package:moviedb/Data/Reposetories/MoviesRepository.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  Genres moviesCategories = Genres(
      allMoviesCategories.map((e) => Genre(e["id"], e["name"])).toList());
  MoviesBloc() : super(MoviesInitial()) {
    on<FetchMoviesEvent>(_fetchbyCategories);
    on<RessetMoviesEvent>(_resetMovies);
  }
  Future<void> _fetchbyCategories(
      FetchMoviesEvent event, Emitter<MoviesState> emit,
      {int p = 1}) async {
    emit(MoviesLoading());
    try {
      Map<String, List<Movie>> moviesList = {};
      for (var cat in moviesCategories.categories) {
        List<Movie> movies =
            await MoviesRepository().getMoviesbyGenre(cat.id, p);
        moviesList.putIfAbsent(cat.name, () => movies);
      }
      emit(MoviesLoaded(moviesList));
    } catch (error) {
      print("_fetchbyCategories Error => $error");
      emit(MoviesError());
    }
  }

  void _resetMovies(MoviesEvent event, Emitter<MoviesState> emit) {
    emit(MoviesInitial());
  }

  Future<void> fetchMoreMovies(Genre g, int p) async {
    Map<String, List<Movie>> moviesList = state.props;
    // ignore: invalid_use_of_visible_for_testing_member
    emit(MoviesLoading());
    try {
      final results = await MoviesRepository().getMoviesbyGenre(g.id, p);
      //print("1-> ${results.length}");
      moviesList[g.name]!.addAll(results);
      //print("2-> ${results.length}");

      // ignore: invalid_use_of_visible_for_testing_member
      emit(MoviesLoaded(moviesList));
    } catch (err) {
      print("fetchMoreMovies Error => $err");
      // ignore: invalid_use_of_visible_for_testing_member
      emit(MoviesError());
    }
  }

  void resetMoreMovies(Genre g) {
    Map<String, List<Movie>> moviesList = state.props;

    moviesList[g.name]!.removeRange(20, moviesList[g.name]!.length);

    // ignore: invalid_use_of_visible_for_testing_member
    emit(MoviesLoaded(moviesList));
  }
}
