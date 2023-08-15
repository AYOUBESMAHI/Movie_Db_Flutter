import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../Constants/Strings.dart';

class SearchWebService {
  Dio dio = Dio();
  SearchWebService() {
    BaseOptions baseOpsions = BaseOptions(
        baseUrl: baseUrl, headers: headers, receiveDataWhenStatusError: true);
    dio = Dio(baseOpsions);
  }

  Map<String, dynamic> generatePath(String g, {int p = 1}) {
    Map<String, dynamic> path = {
      "path": "",
      "params": {
        "query": g,
        "include_adult": false,
        "page": p,
        "without_genres": "99,18",
      }
    };
    path["path"] = "/search/multi";

    return path;
  }

  Future<Map<String, dynamic>> getSearch(String query, int p) async {
    try {
      var path = generatePath(query, p: p);
      var response =
          await dio.get(path["path"], queryParameters: path["params"]);
      return {
        "results": response.data["results"],
        "MaxPages": response.data["total_pages"],
      };
    } catch (err) {
      debugPrint("getSearch Error in SearchWebService ====>  $err");

      return {};
    }
  }
}
