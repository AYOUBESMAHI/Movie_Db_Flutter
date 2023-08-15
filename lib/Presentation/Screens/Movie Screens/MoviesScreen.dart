import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Business Logic/Movie/movies_bloc.dart';

import '../../Widgets/MoviesCategoryList.dart';
import '../../Widgets/TrendsList.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  late MoviesBloc _moviesBloc;
  @override
  void initState() {
    super.initState();
    _moviesBloc = BlocProvider.of<MoviesBloc>(context);
    if (_moviesBloc.state is MoviesInitial) {
      _moviesBloc.add(FetchMoviesEvent());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_moviesBloc.state is! MoviesLoaded) {
      _moviesBloc.add(RessetMoviesEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MoviesBloc, MoviesState>(
        bloc: _moviesBloc,
        builder: (context, state) {
          if (state is MoviesLoaded) {
            var elements = state.genremovies;
            return CustomScrollView(
              slivers: [
                //Trends
                SliverAppBar(
                  expandedHeight: 500,
                  pinned: false,
                  stretch: true,
                  flexibleSpace: FlexibleSpaceBar(
                      background: TrendList(elements["Now Playing"]!)),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      //Genres
                      const SizedBox(height: 5),

                      Column(children: [
                        ...elements.entries.map((e) => BlocProvider.value(
                              value: _moviesBloc,
                              child: MoviesCategoryList(_moviesBloc
                                  .moviesCategories
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
