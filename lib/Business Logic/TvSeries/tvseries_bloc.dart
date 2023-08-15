import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moviedb/Constants/Strings.dart';
import 'package:moviedb/Data/Models/TvSeries.dart';
import 'package:moviedb/Data/Reposetories/SeriesRepository.dart';

import '../../Data/Models/Genre.dart';

part 'tvseries_event.dart';
part 'tvseries_state.dart';

class TvseriesBloc extends Bloc<TvseriesEvent, TvseriesState> {
  Genres seriesCategories =
      Genres(allTvCategories.map((e) => Genre(e["id"], e["name"])).toList());
  TvseriesBloc() : super(TvseriesInitial()) {
    on<FetchTvseries>(_fetchTvSeries);
    on<RessetSeriesEvent>(_resetseries);
  }

  Future<void> _fetchTvSeries(
      FetchTvseries event, Emitter<TvseriesState> emit) async {
    emit(TvseriesLoading());
    try {
      Map<String, List<TvSerie>> seriesList = {};
      for (var cat in seriesCategories.categories) {
        List<TvSerie> series =
            await SeriesRepository().getseriesbyGenre(cat.id, 1);
        seriesList.putIfAbsent(cat.name, () => series);
      }
      emit(TvseriesLoaded(seriesList));
    } catch (error) {
      print("_fetchbyCategories Error => $error");
      emit(TvseriesError());
    }
  }

  void _resetseries(RessetSeriesEvent event, Emitter<TvseriesState> emit) {
    emit(TvseriesInitial());
  }

  Future<void> fetchMoreSeries(Genre g, int p) async {
    Map<String, List<TvSerie>> moviesList = state.props;
    // ignore: invalid_use_of_visible_for_testing_member
    emit(TvseriesLoading());
    try {
      final results = await SeriesRepository().getseriesbyGenre(g.id, p);
      moviesList[g.name]!.addAll(results);
      //print("2-> ${results.length}");

      // ignore: invalid_use_of_visible_for_testing_member
      emit(TvseriesLoaded(moviesList));
    } catch (err) {
      print("fetchMoreMovies Error => $err");
      // ignore: invalid_use_of_visible_for_testing_member
      emit(TvseriesError());
    }
  }

  void resetMoreSeries(Genre g) {
    Map<String, List<TvSerie>> seriesList = state.props;

    seriesList[g.name]!.removeRange(20, seriesList[g.name]!.length);

    // ignore: invalid_use_of_visible_for_testing_member
    emit(TvseriesLoaded(seriesList));
  }
}
