import 'package:flutter/material.dart';

const String baseUrl = "https://api.themoviedb.org/3/";
const Map<String, dynamic> imageUrl = {
  "logo": "https://image.tmdb.org/t/p/w185/",
  "low": "https://image.tmdb.org/t/p/w300/",
  "med": "https://image.tmdb.org/t/p/w500/",
  "high": "https://image.tmdb.org/t/p/w780/",
};
const Map<String, String> headers = {
  'accept': 'application/json',
  'Authorization':
      'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwODcwMzlmMGM0OGNkM2RlZGJhYTMwMjBlY2Q4YzE0YyIsInN1YiI6IjY0YWRkOTg2YjY4NmI5MDE1MDExYzkyMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.QEYmRaksNlvA8RNHzzpKrfxJwPW06mHp3eChwOYsnbY',
};

const String movies = "/Movies";
const String search = "/Search";
const String series = "/Series";
const String favorites = "/Favorites";

const List<Map<String, dynamic>> allMoviesCategories = [
  {"id": -1, "name": "Now Playing"},
  {"id": -2, "name": "Popular"},
  {"id": -3, "name": "Top Rated"},
  {"id": -4, "name": "Upcoming"},
  {"id": 28, "name": "Action"},
  {"id": 12, "name": "Adventure"},
  {"id": 16, "name": "Animation"},
  {"id": 35, "name": "Comedy"},
  {"id": 80, "name": "Crime"},
  {"id": 10751, "name": "Family"},
  {"id": 14, "name": "Fantasy"},
  {"id": 36, "name": "History"},
  {"id": 27, "name": "Horror"},
  {"id": 10402, "name": "Music"},
  {"id": 9648, "name": "Mystery"},
  {"id": 878, "name": "Science Fiction"},
  {"id": 10770, "name": "TV Movie"},
  {"id": 53, "name": "Thriller"},
  {"id": 10752, "name": "War"},
  {"id": 37, "name": "Western"}
];
const List<Map<String, dynamic>> allTvCategories = [
  {"id": -1, "name": "Airing Today"},
  {"id": -2, "name": "On The Air"},
  {"id": -3, "name": "Popular"},
  {"id": -4, "name": "Top Rated"},
  {"id": 10759, "name": "Action & Adventure"},
  {"id": 16, "name": "Animation"},
  {"id": 35, "name": "Comedy"},
  {"id": 80, "name": "Crime"},
  {"id": 10751, "name": "Family"},
  {"id": 10762, "name": "Kids"},
  {"id": 9648, "name": "Mystery"},
  {"id": 10763, "name": "News"},
  {"id": 10764, "name": "Reality"},
  {"id": 10765, "name": "Sci-Fi & Fantasy"},
  {"id": 10766, "name": "Soap"},
  {"id": 10767, "name": "Talk"},
  {"id": 10768, "name": "War & Politics"},
  {"id": 37, "name": "Western"}
];

Color darkColor = Color.fromRGBO(129, 126, 126, 1);
String profiePic =
    "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";
