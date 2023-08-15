import 'package:moviedb/Data/Models/Media.dart';
import 'package:moviedb/Data/Reposetories/MoviesRepository.dart';

class Movie extends Media {
  Movie();
  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "original_title": originalTitle,
      "overview": overview,
      "release_date": releaseDate,
      "vote_average": voteAverage,
      "poster_path": posterPath,
    };
  }

  @override
  Future<Movie> mapJson(Map<String, dynamic> json) async {
    try {
      final movie = Movie();
      movie.id = json['id'];
      movie.releaseDate = json['release_date'].toString();
      movie.originalTitle = json['original_title'].toString();
      movie.posterPath = json['poster_path'].toString();
      movie.voteAverage = json["vote_average"] * 1.0;
      movie.overview = json['overview'].toString();

      return movie;
    } catch (err) {
      print("Movie.mapJson error Movie ====> $err");
      return Movie();
    }
  }

  @override
  Future<void> setMoreDetails() async {
    try {
      genres = await MoviesRepository().getDetailesGenres(id);
      cats = await MoviesRepository().getCasts(id);
      var result = await MoviesRepository().getimagesbyid(id);

      for (var r in result["backdrops"]) {
        images.add(r["file_path"]);
      }
      Map<String, dynamic> mapWithMaxValue = result["posters"].reduce(
          (map1, map2) =>
              map1['vote_average'] > map2['vote_average'] ? map1 : map2);
      backdropPath = mapWithMaxValue['file_path'].toString();

      similars = await MoviesRepository().getSimilars(id);
    } catch (err) {
      print("setMoreDetails error Movie ====> $err");
    }
  }
}
