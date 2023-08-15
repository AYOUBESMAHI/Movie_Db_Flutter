import 'package:flutter/material.dart';
import 'package:moviedb/Data/Models/TvSeries.dart';

import '../Models/Movie.dart';
import '../WebServices/SearchWebService.dart';

class SearchRepository {
  SearchWebService searchWebService = SearchWebService();

  Future<Map<String, dynamic>> getSearched(String querry, int p) async {
    try {
      var resutlt = await searchWebService.getSearch(querry, p);
      List<Movie> movies = [];
      List<TvSerie> series = [];
      for (var r in resutlt["results"]) {
        if ((r["genre_ids"] != null) &&
            (!(r["genre_ids"] as List).contains(99) &&
                !(r["genre_ids"] as List).contains(18)) &&
            (r["genre_ids"] as List).isNotEmpty) {
          if (r["media_type"] == "movie") {
            movies.add(await Movie().mapJson(r));
          }
          if (r["media_type"] == "tv") {
            series.add(await TvSerie().mapJson(r));
          }
        }
      }
      return {
        "movies": movies,
        "series": series,
        "MaxPages": resutlt["MaxPages"]
      };
    } catch (err) {
      debugPrint("getbyGenre Error in SearchRepository ====>  $err");
      return {};
    }
  }
}
