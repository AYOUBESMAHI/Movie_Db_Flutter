import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Constants/Strings.dart';
//Screens
import 'Movie%20Screens/MoviesScreen.dart';
import 'Favorites Screens/FavoritesScreen.dart';
import 'Search%20Screens/SearchScreen.dart';
import 'TvSeries%20Screens/SeriesScreen.dart';

import '../../Business Logic/Movie/movies_bloc.dart';
import '../../Business%20Logic/TvSeries/tvseries_bloc.dart';
import '../../Business%20Logic/Search/search_bloc.dart';
import '../../Business%20Logic/Favorite/favorites_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Map<String, dynamic>> _listScreens = [];
  int index = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listScreens = [
      {"title": movies, "widget": const MoviesScreen()},
      {"title": series, "widget": const TvSeriesScreen()},
      {"title": search, "widget": const SearchScreen()},
      {"title": favorites, "widget": const FavoritesScreen()},
    ];
  }

  void changeScreen(int i) {
    if (index == i) {
      return;
    }
    setState(() {
      index = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(providers: [
        BlocProvider(
          lazy: false,
          create: (context) => MoviesBloc(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => TvseriesBloc(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => SearchBloc(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => FavoritesBloc(),
        ),
      ], child: _listScreens[index]["widget"] as Widget),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.amber,
          unselectedItemColor: Colors.white54,
          backgroundColor: Colors.black,
          type: BottomNavigationBarType.shifting,
          onTap: (value) => changeScreen(value),
          currentIndex: index,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Movies"),
            BottomNavigationBarItem(icon: Icon(Icons.tv), label: "Tv Series"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "Favorites"),
          ]),
    );
  }
}
