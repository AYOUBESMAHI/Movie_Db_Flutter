class Cast {
  late int id;
  late String originalName;
  late String profilePath;
  late String character;
  late int order;

  Cast.mapJson(Map<String, dynamic> json) {
    id = json['id'];
    originalName = json['original_name'].toString();
    profilePath = json['profile_path'].toString();
    character = json['character'].toString();
    order = json['order'];
  }
}
