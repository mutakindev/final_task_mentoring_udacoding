import 'dart:convert';

List<WisataResponse> wisataResponseFromJson(String str) =>
    List<WisataResponse>.from(
        json.decode(str).map((x) => WisataResponse.fromJson(x)));

String wisataResponseToJson(List<WisataResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WisataResponse {
  WisataResponse({
    this.id,
    this.title,
    this.overview,
    this.duration,
    this.rating,
    this.price,
    this.images,
    this.idCategory,
    this.categoryName,
  });

  String id;
  String title;
  String overview;
  String duration;
  String rating;
  String price;
  List<String> images;
  String idCategory;
  String categoryName;

  static List<String> parseStringAsList(String images) {
    List<String> list = images.substring(1, images.length - 1).split(',');
    return list;
  }

  factory WisataResponse.fromJson(Map<String, dynamic> json) => WisataResponse(
        id: json["id"],
        title: json["title"],
        overview: json["overview"],
        duration: json["duration"],
        rating: json["rating"],
        price: json["price"],
        images: parseStringAsList(json["images"]),
        idCategory: json["id_category"],
        categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "overview": overview,
        "duration": duration,
        "rating": rating,
        "price": price,
        "images": images,
        "id_category": idCategory,
        "category_name": categoryName,
      };
}
