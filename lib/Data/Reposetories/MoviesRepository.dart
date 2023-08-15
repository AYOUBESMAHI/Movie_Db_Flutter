import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Models/Cast.dart';
import '../Models/Genre.dart';
import '../Models/Movie.dart';

import '../WebServices/MoviesWebservice.dart';

class MoviesRepository {
  MoviesWebService moviesWebService = MoviesWebService();

  Future<List<Movie>> getMoviesbyGenre(int genre, int p) async {
    try {
      var resutlt = await moviesWebService.getMovies(genre, p);
      List<Movie> movies = [];
      for (var r in resutlt) {
        movies.add(await Movie().mapJson(r));
      }
      return movies;
    } catch (err) {
      debugPrint("getbyGenre Error in MoviesRepository ====>  $err");
      return [];
    }
  }

  Future<Map<String, dynamic>> getimagesbyid(int id) async {
    try {
      var images = await moviesWebService.getimages(id);

      return images;
    } catch (err) {
      debugPrint("getimagesbyid Error in MoviesRepository ====>  $err");
      return {};
    }
  }

  Future<List<Movie>> getSimilars(int id) async {
    try {
      var resutlt = await moviesWebService.getsimilars(id);
      List<Movie> movies = [];
      for (var r in resutlt) {
        if ((r["genre_ids"] != null) &&
            (!(r["genre_ids"] as List).contains(99) &&
                !(r["genre_ids"] as List).contains(18))) {
          movies.add(await Movie().mapJson(r));
        }
      }
      return movies;
    } catch (err) {
      debugPrint("getimagesbyid Error in MoviesRepository ====>  $err");
      return [];
    }
  }

  Future<List<Genre>> getDetailesGenres(int id) async {
    try {
      var details = await moviesWebService.getDetails(id);
      List<Genre> genres = [];
      genres = (details['genres'] as List<dynamic>)
          .map((e) => Genre.mapjson(e))
          .toList();

      return genres;
    } catch (err) {
      debugPrint("getDetails Error in MoviesRepository ====>  $err");
      return [];
    }
  }

  Future<List<Cast>> getCasts(int id) async {
    try {
      var result = await moviesWebService.getCasts(id);
      List<Cast> casts = [];
      casts = result.map((e) => Cast.mapJson(e)).toList();
      //casts.sort((a, b) => a.order.compareTo(b.order));
      casts.removeWhere((e) => e.profilePath == "" || e.profilePath == "null");
      return casts;
    } catch (err) {
      debugPrint("getCasts Error in MoviesRepository ====>  $err");
      return [];
    }
  }
}
