import 'Cast.dart';
import 'Genre.dart';

abstract class Media {
  late int id = 0;
  late List<Genre> genres = [];
  late String originalTitle = "";
  late String overview = "";
  late String releaseDate = "";
  late double voteAverage = 0;
  late String posterPath = "";
  late String backdropPath = "";
  late List<Media> similars = [];
  late List<String> images = [];
  late List<Cast> cats = [];

  Future<void> setMoreDetails();

  Future<Media> mapJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}
