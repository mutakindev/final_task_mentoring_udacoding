// To parse this JSON data, do
//
//     final categoryResponse = categoryResponseFromJson(jsonString);

import 'dart:convert';

List<PlantCategoryResponse> plantCategoryResponseFromJson(String str) =>
    List<PlantCategoryResponse>.from(
        json.decode(str).map((x) => PlantCategoryResponse.fromJson(x)));

String categoryResponseToJson(List<PlantCategoryResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlantCategoryResponse {
  PlantCategoryResponse({
    this.idCategory,
    this.categoryName,
  });

  String idCategory;
  String categoryName;

  factory PlantCategoryResponse.fromJson(Map<String, dynamic> json) =>
      PlantCategoryResponse(
        idCategory: json["id"],
        categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": idCategory,
        "category_name": categoryName,
      };
}
