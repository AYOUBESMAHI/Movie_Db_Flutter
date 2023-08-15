import 'package:moviedb/Data/Models/Media.dart';
import 'package:moviedb/Data/Reposetories/SeriesRepository.dart';

class TvSerie extends Media {
  TvSerie();
  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "original_name": originalTitle,
      "overview": overview,
      "first_air_date": releaseDate,
      "vote_average": voteAverage,
      "poster_path": posterPath,
    };
  }

  @override
  Future<TvSerie> mapJson(Map<String, dynamic> json) async {
    try {
      final serie = TvSerie();
      serie.id = json['id'];
      serie.releaseDate = json['first_air_date'].toString();
      serie.originalTitle = json['original_name'].toString();
      serie.posterPath = json['poster_path'].toString();
      serie.voteAverage = json["vote_average"] * 1.0;
      //movie.backdropPath = json['backdrop_path'].toString();
      serie.overview = json['overview'].toString();

      return serie;
    } catch (err) {
      print("Movie.mapJson error TvSerie ====> $err");
      return TvSerie();
    }
  }

  @override
  Future<void> setMoreDetails() async {
    try {
      genres = await SeriesRepository().getDetailes_Genres(id);
      cats = await SeriesRepository().getCasts(id);

      var result = await SeriesRepository().getimagesbyid(id);

      for (var r in result["backdrops"]) {
        images.add(r["file_path"]);
      }
      Map<String, dynamic> mapWithMaxValue = result["posters"].reduce(
          (map1, map2) =>
              map1['vote_average'] > map2['vote_average'] ? map1 : map2);
      backdropPath = mapWithMaxValue['file_path'].toString();

      similars = await SeriesRepository().getSimilars(id);
    } catch (err) {
      print("setMoreDetails error TvSerie ====> $err");
    }
  }
}
