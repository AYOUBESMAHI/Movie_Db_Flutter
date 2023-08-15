part of 'tvseries_bloc.dart';

abstract class TvseriesEvent extends Equatable {
  const TvseriesEvent();

  @override
  List<Object> get props => [];
}

class FetchTvseries extends TvseriesEvent {}

class RessetSeriesEvent extends TvseriesEvent {}
