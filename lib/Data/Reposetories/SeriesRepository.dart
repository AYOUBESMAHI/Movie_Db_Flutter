import 'package:flutter/material.dart';
import 'package:moviedb/Data/Models/TvSeries.dart';

import '../Models/Cast.dart';
import '../Models/Genre.dart';
import '../WebServices/SeriesWebService.dart';

class SeriesRepository {
  SeriesWebService seriesWebService = SeriesWebService();

  Future<List<TvSerie>> getseriesbyGenre(int genre, int p) async {
    try {
      var resutlt = await seriesWebService.getSeries(genre, p);
      List<TvSerie> series = [];
      for (var r in resutlt) {
        series.add(await TvSerie().mapJson(r));
      }
      return series;
    } catch (err) {
      debugPrint("getbyGenre Error in SeriesRepository ====>  $err");
      return [];
    }
  }

  Future<Map<String, dynamic>> getimagesbyid(int id) async {
    try {
      var images = await seriesWebService.getimages(id);

      return images;
    } catch (err) {
      debugPrint("getimagesbyid Error in SeriesRepository ====>  $err");
      return {};
    }
  }

  Future<List<TvSerie>> getSimilars(int id) async {
    try {
      var resutlt = await seriesWebService.getsimilars(id);
      List<TvSerie> series = [];
      for (var r in resutlt) {
        if ((r["genre_ids"] != null) &&
            (!(r["genre_ids"] as List).contains(99) &&
                !(r["genre_ids"] as List).contains(18))) {
          series.add(await TvSerie().mapJson(r));
        }
      }
      return series;
    } catch (err) {
      debugPrint("getimagesbyid Error in SeriesRepository ====>  $err");
      return [];
    }
  }

  Future<List<Genre>> getDetailes_Genres(int id) async {
    try {
      var details = await seriesWebService.getDetails(id);
      List<Genre> genres = [];
      genres = (details['genres'] as List<dynamic>)
          .map((e) => Genre.mapjson(e))
          .toList();
      return genres;
    } catch (err) {
      debugPrint("getDetails Error in SeriesRepository ====>  $err");
      return [];
    }
  }

  Future<List<Cast>> getCasts(int id) async {
    try {
      var result = await seriesWebService.getCasts(id);
      List<Cast> casts = [];
      casts = result.map((e) => Cast.mapJson(e)).toList();
      //casts.sort((a, b) => a.order.compareTo(b.order));
      casts.removeWhere((e) => e.profilePath == "" || e.profilePath == "null");

      return casts;
    } catch (err) {
      debugPrint("getDetails Error in SeriesRepository ====>  $err");
      return [];
    }
  }
}
