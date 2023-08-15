part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class FetchFavesEvent extends FavoritesEvent {}

class CheckFavesEvent extends FavoritesEvent {
  final String type;
  final Media media;
  const CheckFavesEvent(this.type, this.media);
}

class AddFaveEvent extends FavoritesEvent {
  final String type;
  final Media media;
  const AddFaveEvent(this.type, this.media);
}

class DeleteFaveEvent extends FavoritesEvent {
  final String type;
  final Media media;
  const DeleteFaveEvent(this.type, this.media);
}
