class Genre {
  late int id;
  late String name;
  Genre(this.id, this.name);
  Genre.mapjson(Map<String, dynamic> json) {
    try {
      id = json["id"];
      name = json["name"].toString();
    } catch (err) {
      print("Genre Map Err ==> $err");
    }
  }
}

class Genres {
  final List<Genre> categories;
  Genres(this.categories);
  // static final List<Genre> seriescategories =
  //     allTvCategories.map((e) => Genre(e["id"], e["name"])).toList();

  String getcategoryByid(int id) {
    return categories.firstWhere((element) => element.id == id).name;
  }

  Genre getgenreById(int id) {
    return categories.firstWhere((element) => element.id == id);
  }

  Genre getgenreByName(String n) {
    return categories.firstWhere((element) => element.name == n);
  }
}
