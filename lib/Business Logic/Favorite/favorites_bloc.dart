import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../Data/Reposetories/FavoritesRepository.dart';

import '../../Data/Models/Media.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesInitial()) {
    on<AddFaveEvent>(addFaves);
    on<DeleteFaveEvent>(deleteFaves);
    on<FetchFavesEvent>(fetchFaves);
    on<CheckFavesEvent>(checkFaves);
  }
  Future<void> addFaves(
      AddFaveEvent event, Emitter<FavoritesState> emit) async {
    emit(FavoritesLoading());
    await FavoritesRepository().setMediaToPreference(event.type, event.media);
    emit(FavoritesUpdated());
  }

  Future<void> deleteFaves(
      DeleteFaveEvent event, Emitter<FavoritesState> emit) async {
    emit(FavoritesLoading());
    await FavoritesRepository()
        .removeMediaInPreference(event.type, event.media);
    emit(FavoritesUpdated());
  }

  Future<void> fetchFaves(
      FavoritesEvent event, Emitter<FavoritesState> emit) async {
    emit(FavoritesLoading());
    Map<String, List<Media>> lists =
        await FavoritesRepository().fetchMediaInPreference();

    emit(FavoritesLoaded([...lists["Movies"]!, ...lists["Series"]!]));
  }

  Future<void> checkFaves(
      CheckFavesEvent event, Emitter<FavoritesState> emit) async {
    emit(FavoritesLoading());
    bool isFav =
        await FavoritesRepository().checkIsFav(event.type, event.media);

    emit(FavoriteChecked(isFav));
  }
}
