import 'dart:convert';

List<ComicModel> comicModelFromJson(String str) => List<ComicModel>.from(json.decode(str).map((x) => ComicModel.fromJson(x)));

String comicModelToJson(List<ComicModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class ComicModel {
    ComicModel({
      this.id,
      required  this.description,
      required  this.isExist,
      required  this.pathImage,
      required  this.title,
    });

    int ? id;
    String description;
    int isExist;
    String pathImage;
    String title;

    factory ComicModel.fromJson(Map<String, dynamic> json) => ComicModel(
        id: json["id"],
        description: json["description"],
        isExist: json["is_exist"],
        pathImage: json["path_image"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "is_exist": isExist,
        "path_image": pathImage,
        "title": title,
    };
}

class ComicTotalModel {
  ComicTotalModel({
      required this.pending,
      required this.completed,
      required this.total
  });

  int pending;
  int completed;
  int total;

  factory ComicTotalModel.fromJson(List<Map<String, dynamic>> json){
    int _total = 0;
    int _pending = 0;
    int _completed = 0;
    json.forEach((item) {
      if(item['is_exist'] == 1){
        _completed = item['total'];
      } else {
        _pending = item['total'];
      }
      _total += item['total'] as int;
    });
    return ComicTotalModel(pending: _pending, completed: _completed, total:_total);
  }

  Map<String, dynamic> toJson() => {
    "total": total,
    "completed": completed,
    "pending": pending,
  };

}

