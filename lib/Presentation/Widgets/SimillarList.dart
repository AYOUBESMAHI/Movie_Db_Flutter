import 'package:flutter/material.dart';

import '../../Constants/Constants.dart';

import '../../Constants/Strings.dart';
import '../../Data/Models/Media.dart';
import '../Screens/DetailsScreen.dart';

class SimilarList extends StatelessWidget {
  final List<Media> medias;
  SimilarList(this.medias);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 6, top: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Similar',
            style: Constants.headStyle(),
          ),
          const SizedBox(height: 8),
          Container(
            height: 200,
            child: ListView.builder(
              itemBuilder: (_, i) => GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => DetailsScreen(medias[i]))),
                child: Container(
                  height: 600,
                  width: 150,
                  color: darkColor,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                  child:
                      Constants.buildPlaceHolder(medias[i].posterPath, "low"),
                ),
              ),
              itemCount: medias.length,
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
    );
  }
}
