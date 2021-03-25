import 'package:http/http.dart' as http;
import 'package:parawisata_mutakin/model/categories_model.dart';
import 'package:parawisata_mutakin/model/plant_categories.dart';
import 'package:parawisata_mutakin/model/plant_model.dart';
import 'package:parawisata_mutakin/model/wisata_model.dart';

class ApiServices {
  Future<List<WisataResponse>> getDataWisata() async {
    var url = Uri.https('flutter-task4.000webhostapp.com', '/api/wisata');

    final response = await http.get(url);
    return wisataResponseFromJson(response.body);
  }

  Future<List<CategoryResponse>> getDataCategories() async {
    var url = Uri.https('flutter-task4.000webhostapp.com', '/api/categories');

    final response = await http.get(url);
    return categoryResponseFromJson(response.body);
  }

  Future<List<PlantsResponse>> getDataPlants() async {
    var url = Uri.https('flutter-task4.000webhostapp.com', '/api/plants');

    final response = await http.get(url);
    return plantsResponseFromJson(response.body);
  }

  Future<List<PlantCategoryResponse>> getPlacementCategories() async {
    var url =
        Uri.https('flutter-task4.000webhostapp.com', '/api/plant_categories');

    final response = await http.get(url);
    return plantCategoryResponseFromJson(response.body);
  }
}
