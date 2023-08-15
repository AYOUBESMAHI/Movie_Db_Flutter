import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Business%20Logic/TvSeries/tvseries_bloc.dart';
import '../../../Data/Models/TvSeries.dart';

import '../../../Data/Models/Genre.dart';

import '../DetailsScreen.dart';
import '../../Widgets/SingleElement.dart';

class SeeAllSeriesScreen extends StatefulWidget {
  final Genre genre;

  const SeeAllSeriesScreen(this.genre, {super.key});

  @override
  State<SeeAllSeriesScreen> createState() => _SeeAllSeriesScreenState();
}

class _SeeAllSeriesScreenState extends State<SeeAllSeriesScreen> {
  List<TvSerie> series = [];
  late TvseriesBloc _bloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = BlocProvider.of<TvseriesBloc>(context);
    series = _bloc.state.props[widget.genre.name];
  }

  int page = 1;

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.genre.name)),
      body: BlocConsumer<TvseriesBloc, TvseriesState>(
        listener: (context, state) {
          if (state is TvseriesLoaded && isloading) {
            setState(() {
              series = state.props[widget.genre.name] as List<TvSerie>;
              isloading = false;
            });
          } else {
            isloading = true;
          }
        },
        builder: (context, state) {
          return Column(children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(5),
                itemBuilder: (ctx, i) {
                  if (i >= series.length) {
                    return !isloading
                        ? ElevatedButton(
                            onPressed: !isloading
                                ? () {
                                    setState(() {
                                      page++;
                                      _bloc.fetchMoreSeries(widget.genre, page);
                                    });
                                  }
                                : null,
                            child: const Text(
                              "Load More",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ))
                        : const Center(
                            child: CircularProgressIndicator(
                              color: Colors.amber,
                            ),
                          );
                  } else {
                    return InkWell(
                        onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => DetailsScreen(series[i])),
                            ),
                        child: SingleElement(series[i], false));
                  }
                },
                itemCount: series.length + 1,
              ),
            ),
          ]);
        },
      ),
    );
  }
}
