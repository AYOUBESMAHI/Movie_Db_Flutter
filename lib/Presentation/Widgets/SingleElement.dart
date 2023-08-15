import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../../Business%20Logic/Favorite/favorites_bloc.dart';

import '../../Constants/Constants.dart';

import '../../Constants/Strings.dart';
import '../../Data/Models/Media.dart';
import '../../Data/Models/Movie.dart';

// ignore: must_be_immutable
class SingleElement extends StatefulWidget {
  final Media media;
  final bool isDetails;

  SingleElement(this.media, this.isDetails, {super.key});

  @override
  State<SingleElement> createState() => _SingleElementState();
}

class _SingleElementState extends State<SingleElement> {
  bool isFav = false;
  late FavoritesBloc bloc;
  String type = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    type = (widget.media.runtimeType == Movie) ? "Movies" : "Series";
    bloc = BlocProvider.of<FavoritesBloc>(context);
    bloc.add(CheckFavesEvent(type, widget.media));
  }

  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateFormat formatter = DateFormat('MMMM dd, yyyy');
    String formattedDate = formatter.format(date);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 120,
            height: 190,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: darkColor,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Hero(
                tag: widget.media.id,
                child:
                    Constants.buildPlaceHolder(widget.media.posterPath, "low"),
              ),
            ),
          ),
        ),
        const SizedBox(width: 7),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.media.originalTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                formatDate(widget.media.releaseDate),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
              Row(children: [
                RatingBar.builder(
                  ignoreGestures: true,
                  initialRating: widget.media.voteAverage / 2,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 20,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                const SizedBox(width: 15),
                Text(
                  "${widget.media.voteAverage}/10",
                  style: const TextStyle(
                    color: Colors.amber,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ]),
              if (widget.isDetails) const SizedBox(height: 5),
              if (widget.isDetails)
                RichText(
                    text: TextSpan(
                        text: "Genre : ",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                        children: [
                      ...List.generate(
                          widget.media.genres.length,
                          (i) => TextSpan(
                                text: "${widget.media.genres[i].name},",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              )),
                    ])),
              if (widget.isDetails)
                BlocConsumer<FavoritesBloc, FavoritesState>(
                    bloc: BlocProvider.of<FavoritesBloc>(context),
                    listener: (context, state) {
                      if (state is FavoriteChecked) {
                        setState(() {
                          isFav = state.isfav;
                        });
                      }
                      if (state is FavoritesUpdated) {
                        setState(() {});
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton.icon(
                        onPressed: () {
                          if (!isFav) {
                            isFav = true;
                            bloc.add(AddFaveEvent(type, widget.media));
                          } else {
                            isFav = false;

                            bloc.add(DeleteFaveEvent(type, widget.media));
                          }
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: isFav ? Colors.red : Colors.amber,
                        ),
                        label: const Text(
                          "Your Favorite",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                Colors.black45)),
                      );
                    })
            ],
          ),
        ),
      ]),
    );
  }
}
