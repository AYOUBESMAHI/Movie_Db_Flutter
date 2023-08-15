part of 'favorites_bloc.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesError extends FavoritesState {}

class FavoriteChecked extends FavoritesState {
  final bool isfav;
  const FavoriteChecked(this.isfav);
}

class FavoritesUpdated extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<Media> faves;
  const FavoritesLoaded(this.faves);
}
