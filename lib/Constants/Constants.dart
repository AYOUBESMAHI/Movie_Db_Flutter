import 'package:flutter/material.dart';

import 'Strings.dart';

class Constants {
  static TextStyle headStyle() {
    return const TextStyle(
      fontSize: 23,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
  }

  static Widget buildPlaceHolder(String url, String? quality) {
    if (quality == "logo") {
      if ((url == "null" || url == "")) {
        return Image.network(
          profiePic,
          fit: BoxFit.fill,
        );
      } else {
        return Image.network(
          imageUrl[quality!] + url,
          fit: BoxFit.fill,
        );
      }
    }
    return (url == "null" || url == "")
        ? Image.asset(
            "Assets/Images/1887013-middle.png",
            fit: quality == "med" ? BoxFit.none : BoxFit.contain,
          )
        : FadeInImage.assetNetwork(
            placeholder: "Assets/Images/gx06Zt3MRp.gif",
            image: imageUrl[quality!] + url,
            fit: BoxFit.cover,
            placeholderFit: BoxFit.contain,
          );
  }
}
