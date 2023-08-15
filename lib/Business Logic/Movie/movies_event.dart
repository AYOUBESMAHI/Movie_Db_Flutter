part of 'movies_bloc.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object> get props => [];
}

class FetchMoviesEvent extends MoviesEvent {}

class FetchMoreMoviesEvent extends MoviesEvent {}

class RessetMoviesEvent extends MoviesEvent {}
