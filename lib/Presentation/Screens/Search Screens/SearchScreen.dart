import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/Constants/Constants.dart';

import '../../../Business Logic/Search/search_bloc.dart';
import '../DetailsScreen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late SearchBloc _searchbloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchbloc = BlocProvider.of<SearchBloc>(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // FocusScope.of(context).unfocus();
    _searchbloc.add(ResetSearchMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: Constants.headStyle(),
                icon: const Icon(Icons.search),
                iconColor: Colors.white,
                border: InputBorder.none,
              ),
              textInputAction: TextInputAction.search,
              cursorColor: Colors.white,
              onSubmitted: (val) => _searchbloc.add(FetchSeriesMovies(val, 1)),
            ),
          )
        ],
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        bloc: _searchbloc,
        builder: (context, state) {
          if (state is SearchLoaded) {
            var medias = [
              ...state.searched["movies"],
              ...state.searched["series"]
            ];

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 1.4,
                mainAxisSpacing: 1.4,
                childAspectRatio: 0.6,
              ),
              itemBuilder: (ctx, i) => GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => DetailsScreen(medias[i]))),
                child: GridTile(
                  footer: Container(
                    height: 30,
                    color: Colors.black54,
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      medias[i].originalTitle,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    child: Hero(
                      tag: medias[i].id,
                      child: Constants.buildPlaceHolder(
                          medias[i].posterPath, "low"),
                    ),
                  ),
                ),
              ),
              itemCount: medias.length,
            );
          }
          if (state is SearchLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return const Text("");
        },
      ),
    );
  }
}
