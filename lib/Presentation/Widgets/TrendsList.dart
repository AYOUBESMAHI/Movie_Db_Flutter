import 'package:flutter/material.dart';
import 'package:moviedb/Constants/Strings.dart';

import '../../Data/Models/Media.dart';

import '../../Constants/Constants.dart';
import '../Screens/DetailsScreen.dart';

class TrendList extends StatefulWidget {
  final List<Media> trends;
  TrendList(this.trends);

  @override
  State<TrendList> createState() => _TrendListState();
}

class _TrendListState extends State<TrendList> {
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8, initialPage: 3);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemBuilder: (_, i) => GestureDetector(
        onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => DetailsScreen(widget.trends[i]))),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          color: darkColor,
          child: Constants.buildPlaceHolder(widget.trends[i].posterPath, "med"),
        ),
      ),
      controller: _pageController,
      scrollDirection: Axis.horizontal,
      itemCount: 7,
    );
  }
}
