import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/Business%20Logic/Favorite/favorites_bloc.dart';

import '../../Constants/Constants.dart';

import '../../Constants/Strings.dart';
import '../../Data/Models/Media.dart';

import '../Widgets/SimillarList.dart';
import '../Widgets/SingleElement.dart';

class DetailsScreen extends StatefulWidget {
  final Media media;
  const DetailsScreen(this.media, {super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
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
      body: FutureBuilder(
          future: widget.media.setMoreDetails(),
          builder: (ctx, s) {
            if (s.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 500,
                    stretch: true,
                    backgroundColor: darkColor,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Constants.buildPlaceHolder(
                          widget.media.backdropPath, "med"),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      BlocProvider.value(
                          value: _favoritesBloc,
                          child: SingleElement(
                            widget.media,
                            true,
                          )),
                      Container(
                        height: 200,
                        margin: const EdgeInsets.only(left: 6, top: 18),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Overview",
                                style: Constants.headStyle(),
                              ),
                              Expanded(
                                  child: Text(
                                widget.media.overview,
                                style: const TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              )),
                            ]),
                      ),
                      if (widget.media.cats.isNotEmpty) buildTopCast(),
                      if (widget.media.images.isNotEmpty) buildMediaImages(),
                      if (widget.media.similars.isNotEmpty)
                        SimilarList(widget.media.similars)
                    ]),
                  ),
                ],
              );
            }
          }),
    );
  }

  Widget buildTopCast() {
    return Container(
      height: 240,
      margin: const EdgeInsets.only(left: 6, top: 18, bottom: 5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Top Cast",
          style: Constants.headStyle(),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            itemBuilder: (_, i) => Container(
              margin: const EdgeInsets.all(5),
              width: 100,
              child: Column(children: [
                SizedBox(
                  height: 130,
                  child: ClipOval(
                    child: Constants.buildPlaceHolder(
                        widget.media.cats[i].profilePath, "logo"),
                  ),
                ),
                const SizedBox(height: 3),
                SizedBox(
                    height: 20,
                    child: Text(
                      widget.media.cats[i].originalName,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    )),
                SizedBox(
                    height: 20,
                    child: Text(
                      widget.media.cats[i].originalName,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    )),
              ]),
            ),
            itemCount: widget.media.cats.length,
            scrollDirection: Axis.horizontal,
          ),
        )
      ]),
    );
  }

  Widget buildMediaImages() {
    return Container(
      height: 300,
      margin: const EdgeInsets.only(left: 6, top: 18, bottom: 5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Images",
          style: Constants.headStyle(),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            itemBuilder: (_, i) => Container(
              margin: const EdgeInsets.only(right: 9),
              child: Constants.buildPlaceHolder(widget.media.images[i], "med"),
            ),
            itemCount: widget.media.images.length,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ]),
    );
  }
}
