import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Data/Models/Movie.dart';

import '../../../Business Logic/Movie/movies_bloc.dart';
import '../../../Data/Models/Genre.dart';

import '../DetailsScreen.dart';
import '../../Widgets/SingleElement.dart';

class SeeAllMoviesScreen extends StatefulWidget {
  final Genre genre;

  const SeeAllMoviesScreen(this.genre, {super.key});

  @override
  State<SeeAllMoviesScreen> createState() => _SeeAllMoviesScreenState();
}

class _SeeAllMoviesScreenState extends State<SeeAllMoviesScreen> {
  List<Movie> movies = [];
  late MoviesBloc _bloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = BlocProvider.of<MoviesBloc>(context);
    movies = _bloc.state.props[widget.genre.name];
  }

  int page = 1;

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.genre.name)),
      body: BlocConsumer<MoviesBloc, MoviesState>(
        listener: (context, state) {
          if (state is MoviesLoaded && isloading) {
            setState(() {
              movies = state.props[widget.genre.name] as List<Movie>;
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
                  if (i >= movies.length) {
                    return !isloading
                        ? ElevatedButton(
                            onPressed: !isloading
                                ? () {
                                    setState(() {
                                      page++;
                                      _bloc.fetchMoreMovies(widget.genre, page);
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
                                  builder: (_) => DetailsScreen(movies[i])),
                            ),
                        child: SingleElement(movies[i], false));
                  }
                },
                itemCount: movies.length + 1,
              ),
            ),
          ]);
        },
      ),
    );
  }
}
