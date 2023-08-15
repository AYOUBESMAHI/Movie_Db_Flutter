import 'dart:convert';

import 'package:moviedb/Data/Models/Media.dart';
import 'package:moviedb/Data/Models/Movie.dart';
import 'package:moviedb/Data/Models/TvSeries.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesRepository {
  late SharedPreferences preferences;
  FavoritesRepository();

  Future<List<Movie>> jsonMovies(List<String> json) async {
    List<Movie> movies = [];
    for (var json in json) {
      movies.add(await Movie().mapJson(jsonDecode(json)));
    }
    return movies;
  }

  Future<List<TvSerie>> jsonSeries(List<String> json) async {
    List<TvSerie> series = [];
    for (var json in json) {
      series.add(await TvSerie().mapJson(jsonDecode(json)));
    }
    return series;
  }

  Future<void> setMediaToPreference(String title, Media media) async {
    preferences = await SharedPreferences.getInstance();
    try {
      var listPref = preferences.getStringList(title);
      if (title == "Movies") {
        List<Movie> movies = await jsonMovies(listPref!);
        movies.add(media as Movie);

        var updatedList = movies.map((e) => jsonEncode(e.toJson())).toList();
        preferences.setStringList(title, updatedList);
      } else {
        List<TvSerie> series = await jsonSeries(listPref!);
        series.add(media as TvSerie);

        var updatedList = series.map((e) => jsonEncode(e.toJson())).toList();
        preferences.setStringList(title, updatedList);
      }
    } catch (err) {
      print("setMediaToPreference  FavoritesRepository Error ==> $err");
    }
  }

  Future<void> removeMediaInPreference(String title, Media media) async {
    preferences = await SharedPreferences.getInstance();
    try {
      String jsonMedia = jsonEncode(media.toJson());

      var listMediasJson = preferences.getStringList(title);
      listMediasJson!.removeWhere((e) => e == jsonMedia);

      preferences.setStringList(title, listMediasJson);
    } catch (err) {
      print("removeMediaInPreference  FavoritesRepository Error ==> $err");
    }
  }

  Future<Map<String, List<Media>>> fetchMediaInPreference() async {
    try {
      preferences = await SharedPreferences.getInstance();
      List<Movie> movies = [];
      if (preferences.containsKey("Movies")) {
        var listmoviesJson = preferences.getStringList("Movies");
        movies = await jsonMovies(listmoviesJson!);
      } else {
        preferences.setStringList("Movies", []);
      }
      List<TvSerie> series = [];
      if (preferences.containsKey("Series")) {
        var listseriesJson = preferences.getStringList("Series");
        series = await jsonSeries(listseriesJson!);
      } else {
        preferences.setStringList("Series", []);
      }
      return {"Movies": movies, "Series": series};
    } catch (err) {
      print("fetchMediaInPreference  FavoritesRepository Error ==> $err");
      return {};
    }
  }

  Future<bool> checkIsFav(String title, Media media) async {
    try {
      preferences = await SharedPreferences.getInstance();
      if (title == "Movies") {
        var listmoviesJson = preferences.getStringList("Movies");
        List<Movie> movies = await jsonMovies(listmoviesJson!);
        return movies.where((e) => e.id == media.id).isNotEmpty;
      } else {
        var listseriesJson = preferences.getStringList("Series");
        List<TvSerie> series = await jsonSeries(listseriesJson!);
        return series.where((e) => e.id == media.id).isNotEmpty;
      }
    } catch (err) {
      print("checkIsFav  FavoritesRepository Error ==> $err");
      return false;
    }
  }
}
