// To parse this JSON data, do
//
//     final plantsResponse = plantsResponseFromJson(jsonString);

import 'dart:convert';

import 'dart:io';

List<PlantsResponse> plantsResponseFromJson(String str) =>
    List<PlantsResponse>.from(
        json.decode(str).map((x) => PlantsResponse.fromJson(x)));

class PlantsResponse {
  PlantsResponse({
    this.id,
    this.plantName,
    this.length,
    this.weight,
    this.diameter,
    this.temperatur,
    this.water,
    this.placement,
    this.information,
    this.image,
    this.category,
    this.categoryName,
  });

  String id;
  String plantName;
  String length;
  String weight;
  String diameter;
  String temperatur;
  String water;
  String placement;
  String information;
  String image;
  String category;
  String categoryName;

  factory PlantsResponse.fromJson(Map<String, dynamic> json) => PlantsResponse(
        id: json["id"],
        plantName: json["plant_name"],
        length: json["length"],
        weight: json["weight"],
        diameter: json["diameter"],
        temperatur: json["temperatur"],
        water: json["water"],
        placement: json["placement"],
        information: json["information"],
        image: json["image"],
        category: json["category"],
        categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "plant_name": plantName,
        "length": length,
        "weight": weight,
        "diameter": diameter,
        "temperatur": temperatur,
        "water": water,
        "placement": placement,
        "information": information,
        "image": image,
        "category": category,
        "category_name": categoryName,
      };
}

class PlantRequest {
  String id;
  String plantName;
  String length;
  String weight;
  String diameter;
  String temperatur;
  String water;
  String placement;
  String information;
  File image;
  String category;

  PlantRequest({
    this.id,
    this.plantName,
    this.length,
    this.weight,
    this.diameter,
    this.temperatur,
    this.water,
    this.placement,
    this.information,
    this.image,
    this.category,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "plant_name": plantName,
        "length": length,
        "weight": weight,
        "diameter": diameter,
        "temperatur": temperatur,
        "water": water,
        "placement": placement,
        "information": information,
        "image": image,
        "category": category,
      };
}
