import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:parawisata_mutakin/model/categories_model.dart';
import 'package:parawisata_mutakin/model/plant_categories.dart';
import 'package:parawisata_mutakin/model/plant_model.dart';
import 'package:parawisata_mutakin/model/wisata_model.dart';

class ApiServices {
  Future<List<WisataResponse>> getDataWisata() async {
    try {
      var url = Uri.https('flutter-task4.000webhostapp.com', '/api/wisata');

      final response = await http.get(url);
      return wisataResponseFromJson(response.body);
    } catch (e) {}
  }

  Future<List<CategoryResponse>> getDataCategories() async {
    try {
      var url = Uri.https('flutter-task4.000webhostapp.com', '/api/categories');

      final response = await http.get(url);
      return categoryResponseFromJson(response.body);
    } catch (e) {}
  }

  // Plants REST API

  Future<List<PlantsResponse>> getDataPlants() async {
    try {
      var url = Uri.https('flutter-task4.000webhostapp.com', '/api/plants');

      final response = await http.get(url);
      return plantsResponseFromJson(response.body);
    } catch (e) {}
  }

  Future<Map<String, dynamic>> addPlant(PlantRequest plant) async {
    try {
      var url = Uri.https('flutter-task4.000webhostapp.com', '/api/add_plant');
      // print(plant.toJson());
      // final response = await http.post(url, body: plant.toJson());
      // print(response.body);

      var request = http.MultipartRequest("POST", url);
      //add text fields
      request.fields["plant_name"] = plant.plantName;
      request.fields["length"] = plant.length;
      request.fields["weight"] = plant.weight;
      request.fields["diameter"] = plant.diameter;
      request.fields["temperatur"] = plant.temperatur;
      request.fields["water"] = plant.water;
      request.fields["placement"] = plant.placement;
      request.fields["information"] = plant.information;
      request.fields["category"] = plant.category;

      //create multipart using filepath, string or bytes
      var pic = await http.MultipartFile.fromPath("image", plant.image.path);
      //add multipart to request
      request.files.add(pic);

      print(request.toString());

      final response = await request.send();

      if (response.statusCode == 200) {
        response.stream.transform(utf8.decoder).listen((value) {
          print(value);
        });
        return {'value': 1, 'message': 'Berhasil ditambahkan'};
      }
    } catch (e) {
      print("error di sini =>>>>> ${e.toString()}");
    }
  }

  Future<Map<String, dynamic>> deletePlant(String plantId) async {
    try {
      var url =
          Uri.https('flutter-task4.000webhostapp.com', '/api/delete_plant');
      print(plantId);
      final response = await http.post(url, body: {"id": plantId});

      print(response.body);
      Map<String, dynamic> object = jsonDecode(response.body);
      return object;
    } catch (e) {}
  }

  Future<Map<String, dynamic>> editPlant(PlantsResponse plant) async {
    try {
      var url = Uri.https('flutter-task4.000webhostapp.com', '/api/edit_plant');
      final response = await http.post(url, body: plant.toJson());

      Map<String, dynamic> object = jsonDecode(response.body);
      return object;
    } catch (e) {}
  }

  // Plant Categories REST API

  Future<List<PlantCategoryResponse>> getPlacementCategories() async {
    try {
      var url =
          Uri.https('flutter-task4.000webhostapp.com', '/api/plant_categories');

      final response = await http.get(url);
      return plantCategoryResponseFromJson(response.body);
    } catch (e) {}
  }

  Future<Map<String, dynamic>> addPlantCategories(String categoryName) async {
    try {
      var url = Uri.https(
          'flutter-task4.000webhostapp.com', '/api/add_plant_categories');
      final response =
          await http.post(url, body: {"categoryName": categoryName});

      Map<String, dynamic> object = jsonDecode(response.body);
      return object;
    } catch (e) {}
  }

  Future<Map<String, dynamic>> deletePlantCategories(String categoryId) async {
    try {
      var url = Uri.https(
          'flutter-task4.000webhostapp.com', '/api/delete_plant_categories');
      final response = await http.post(url, body: {"id": categoryId});

      Map<String, dynamic> object = jsonDecode(response.body);
      return object;
    } catch (e) {}
  }

  Future<Map<String, dynamic>> editPlantCategories(
      String categoryId, String categoryName) async {
    try {
      var url = Uri.https(
          'flutter-task4.000webhostapp.com', '/api/edit_plant_categories');
      final response = await http
          .post(url, body: {"id": categoryId, "categoryName": categoryName});

      Map<String, dynamic> object = jsonDecode(response.body);
      return object;
    } catch (e) {}
  }
}
