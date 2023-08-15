import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../Constants/Strings.dart';

class SeriesWebService {
  Dio dio = Dio();
  SeriesWebService() {
    BaseOptions baseOpsions = BaseOptions(
        baseUrl: baseUrl, headers: headers, receiveDataWhenStatusError: true);
    dio = Dio(baseOpsions);
  }

  Map<String, dynamic> generatePath(int g, {int p = 1}) {
    Map<String, dynamic> path = {
      "path": "",
      "params": {
        "include_adult": false,
        "language": "en-US",
        "page": p,
        "region": "US",
      }
    };

    if (g == -1) {
      path["path"] = "/tv/airing_today";
      return path;
    } else if (g == -2) {
      path["path"] = '/tv/on_the_air';
      return path;
    } else if (g == -3) {
      path["path"] = '/tv/popular';
      return path;
    } else if (g == -4) {
      path["path"] = '/tv/top_rated';
      return path;
    }
    //By Genre
    else {
      path["path"] = '/discover/tv';
      path["params"] = {
        "include_adult": false,
        "language": "en-US",
        "page": p,
        "sort_by": "popularity.desc",
        "with_genres": g,
        "without_genres": "99,18",
      };
      return path;
    }
  }

  Future<List<dynamic>> getSeries(int genre, int p) async {
    try {
      var path = generatePath(genre, p: p);
      var response =
          await dio.get(path["path"], queryParameters: path["params"]);
      return response.data["results"];
    } catch (err) {
      debugPrint("getcategory Error in SeriesWebService ====>  $err");

      return [];
    }
  }

  Future<Map<String, dynamic>> getimages(int id) async {
    try {
      var response = await dio.get("/tv/$id/images");
      return {
        "backdrops": response.data["backdrops"],
        "posters": response.data["posters"]
      };
    } catch (err) {
      debugPrint("getimages Error in SeriesWebService ====>  $err");

      return {};
    }
  }

  Future<List<dynamic>> getsimilars(int id) async {
    try {
      var response = await dio.get("/tv/$id/similar");
      return response.data["results"];
    } catch (err) {
      debugPrint("getsimilars Error in SeriesWebService ====>  $err");

      return [];
    }
  }

  Future<List<dynamic>> getCasts(int id) async {
    try {
      var response = await dio.get("/tv/$id/credits");
      return response.data["cast"];
    } catch (err) {
      debugPrint("getCasts Error in SeriesWebService ====>  $err");

      return [];
    }
  }

  Future<dynamic> getDetails(int id) async {
    try {
      var response = await dio.get("/tv/$id");
      return response.data;
    } catch (err) {
      debugPrint("getDetails Error in SeriesWebService ====>  $err");

      return [];
    }
  }
}
