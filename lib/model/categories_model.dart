// To parse this JSON data, do
//
//     final categoryResponse = categoryResponseFromJson(jsonString);

import 'dart:convert';

List<CategoryResponse> categoryResponseFromJson(String str) =>
    List<CategoryResponse>.from(
        json.decode(str).map((x) => CategoryResponse.fromJson(x)));

String categoryResponseToJson(List<CategoryResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryResponse {
  CategoryResponse({
    this.idCategory,
    this.categoryName,
  });

  String idCategory;
  String categoryName;

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      CategoryResponse(
        idCategory: json["id_category"],
        categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "id_category": idCategory,
        "category_name": categoryName,
      };
}
