part of 'tvseries_bloc.dart';

abstract class TvseriesState {
  const TvseriesState();

  dynamic get props => {};
}

class TvseriesInitial extends TvseriesState {}

class TvseriesLoading extends TvseriesState {}

class TvseriesError extends TvseriesState {}

class TvseriesLoaded extends TvseriesState {
  final Map<String, List<TvSerie>> series;

  TvseriesLoaded(this.series);

  @override
  Map<String, List<TvSerie>> get props => {...series};
}
