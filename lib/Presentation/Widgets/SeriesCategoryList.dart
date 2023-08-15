import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/Data/Models/TvSeries.dart';
import 'package:moviedb/Presentation/Screens/TvSeries%20Screens/SeeAllSeriesScreen.dart';

import '../../Business%20Logic/TvSeries/tvseries_bloc.dart';

import '../../Data/Models/Genre.dart';

import '../../Constants/Constants.dart';

import '../Screens/DetailsScreen.dart';

class SeriesCategoryList extends StatelessWidget {
  final Genre genre;
  const SeriesCategoryList(this.genre, {super.key});
  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<TvseriesBloc>(context);
    final List<TvSerie> series = _bloc.state.props[genre.name];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  genre.name,
                  style: const TextStyle(
                    color: Colors.amber,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                InkWell(
                    onTap: () => Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                                  value: _bloc,
                                  child: SeeAllSeriesScreen(genre),
                                )))
                        .then((value) => _bloc.resetMoreSeries(genre)),
                    child: const Text(
                      "See all",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    )),
              ],
            ),
          ),
          Container(
            height: 300,
            margin: const EdgeInsets.only(top: 4),
            child: ListView.builder(
              itemBuilder: (_, i) => GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => DetailsScreen(series[i]))),
                child: Container(
                  width: 150,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                  child: Column(children: [
                    SizedBox(
                      height: 250,
                      child: Constants.buildPlaceHolder(
                          series[i].posterPath, "low"),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      height: 30,
                      child: Text(
                        series[i].originalTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ]),
                ),
              ),
              itemCount: series.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
          const Divider(
            color: Colors.white,
            endIndent: 1,
          ),
        ],
      ),
    );
  }
}
