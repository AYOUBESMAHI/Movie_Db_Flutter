import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/Presentation/Widgets/SeriesCategoryList.dart';

import '../../../Business Logic/TvSeries/tvseries_bloc.dart';

import '../../Widgets/TrendsList.dart';

class TvSeriesScreen extends StatefulWidget {
  const TvSeriesScreen({super.key});

  @override
  State<TvSeriesScreen> createState() => _TvSeriesScreenState();
}

class _TvSeriesScreenState extends State<TvSeriesScreen> {
  late TvseriesBloc _seriesBloc;

  @override
  void initState() {
    super.initState();

    _seriesBloc = BlocProvider.of<TvseriesBloc>(context);
    if (_seriesBloc.state is TvseriesInitial) {
      _seriesBloc.add(FetchTvseries());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_seriesBloc.state is! TvseriesLoaded) {
      _seriesBloc.add(RessetSeriesEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvseriesBloc, TvseriesState>(
        bloc: _seriesBloc,
        builder: (context, state) {
          if (state is TvseriesLoaded) {
            var elements = state.series;
            return CustomScrollView(
              slivers: [
                //Trends
                SliverAppBar(
                  expandedHeight: 500,
                  pinned: false,
                  stretch: true,
                  flexibleSpace: FlexibleSpaceBar(
                      background: TrendList(elements["Airing Today"]!)),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      //Genres
                      const SizedBox(height: 5),

                      Column(children: [
                        ...elements.entries.map((e) => BlocProvider.value(
                              value: _seriesBloc,
                              child: SeriesCategoryList(_seriesBloc
                                  .seriesCategories
                                  .getgenreByName(e.key)),
                            ))
                      ]),
                    ],
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
