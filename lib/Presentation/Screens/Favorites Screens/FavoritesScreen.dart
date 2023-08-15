import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/Business%20Logic/Favorite/favorites_bloc.dart';
import 'package:moviedb/Presentation/Widgets/SingleElement.dart';

import '../../../Data/Models/Media.dart';
import '../DetailsScreen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late FavoritesBloc _favoritesBloc;
  @override
  void initState() {
    super.initState();
    _favoritesBloc = FavoritesBloc();
    _favoritesBloc.add(FetchFavesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favorites",
          style: TextStyle(
              color: Colors.amber, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
          bloc: _favoritesBloc,
          builder: (ctx, state) {
            if (state is FavoritesLoaded) {
              List<Media> medias = state.faves;
              return ListView.builder(
                itemBuilder: (ctx, i) => GestureDetector(
                    onTap: () => Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (_) => DetailsScreen(medias[i])))
                        .then((value) => _favoritesBloc.add(FetchFavesEvent())),
                    child: SingleElement(medias[i], false)),
                itemCount: medias.length,
              );
            }

            if (state is FavoritesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const Text("");
          }),
    );
  }
}
