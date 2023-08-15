part of 'movies_bloc.dart';

abstract class MoviesState {
  const MoviesState();

  dynamic get props => {};
}

class MoviesInitial extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesError extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final Map<String, List<Movie>> genremovies;
  const MoviesLoaded(this.genremovies);
  @override
  Map<String, List<Movie>> get props => {...genremovies};
}
