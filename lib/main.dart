import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/Business%20Logic/Favorite/favorites_bloc.dart';
import 'package:moviedb/Presentation/Screens/MainScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(useMaterial3: true).copyWith(
          appBarTheme: const AppBarTheme(color: Colors.black54),
          // scaffoldBackgroundColor: Colors.black87,
          progressIndicatorTheme: const ProgressIndicatorThemeData(
              color: Color.fromRGBO(255, 193, 7, 1)),
        ),
        home: const MainScreen(),
      ),
    );
  }
}
