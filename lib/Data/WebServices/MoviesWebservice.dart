import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../Constants/Strings.dart';

class MoviesWebService {
  Dio dio = Dio();
  MoviesWebService() {
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
    //Trend
    if (g == -1) {
      path["path"] = "/movie/now_playing";
      return path;
    }
    //Popular
    else if (g == -2) {
      path["path"] = '/movie/popular';
      return path;
    } else if (g == -3) {
      path["path"] = '/movie/top_rated';
      return path;
    } else if (g == -4) {
      path["path"] = '/movie/upcoming';
      return path;
    }
    //By Genre
    else {
      path["path"] = '/discover/movie';
      path["params"] = {
        "include_adult": false,
        "language": "en-US",
        "page": p,
        "sort_by": "popularity.desc",
        "with_genres": g,
        "region": "US",
        "without_genres": "99,18",
      };
      return path;
    }
  }

  Future<List<dynamic>> getMovies(int genre, int p) async {
    try {
      var path = generatePath(genre, p: p);

      var response =
          await dio.get(path["path"], queryParameters: path["params"]);
      return response.data["results"];
    } catch (err) {
      debugPrint("getcategory Error in WebService ====>  $err");

      return [];
    }
  }

  Future<Map<String, dynamic>> getimages(int id) async {
    try {
      var response = await dio.get("/movie/$id/images");
      return {
        "backdrops": response.data["backdrops"],
        "posters": response.data["posters"]
      };
    } catch (err) {
      debugPrint("getimages Error in WebService ====>  $err");

      return {};
    }
  }

  Future<List<dynamic>> getsimilars(int id) async {
    try {
      var response = await dio.get("/movie/$id/similar");
      return response.data["results"];
    } catch (err) {
      debugPrint("getsimilars Error in WebService ====>  $err");

      return [];
    }
  }

  Future<List<dynamic>> getCasts(int id) async {
    try {
      var response = await dio.get("/movie/$id/credits");
      return response.data["cast"];
    } catch (err) {
      debugPrint("getCasts Error in WebService ====>  $err");

      return [];
    }
  }

  Future<dynamic> getDetails(int id) async {
    try {
      var response = await dio.get("/movie/$id");
      return response.data;
    } catch (err) {
      debugPrint("getDetails Error in WebService ====>  $err");

      return [];
    }
  }
}
