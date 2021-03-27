import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parawisata_mutakin/bloc/plant_categories_bloc.dart';
import 'package:parawisata_mutakin/model/categories_model.dart';
import 'package:parawisata_mutakin/model/plant_categories.dart';
import 'package:parawisata_mutakin/network/services.dart';
import 'package:parawisata_mutakin/ui/data_by_kategory.dart';
import 'package:parawisata_mutakin/utils.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  PlantCategoriesBloc _plantCategoriesBloc = PlantCategoriesBloc();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ApiServices _apiServices = ApiServices();
  TextEditingController categoryName = TextEditingController();

  @override
  void initState() {
    super.initState();
    _plantCategoriesBloc.add(GetPlantCategoriesList());
  }

  @override
  void dispose() {
    super.dispose();
    _plantCategoriesBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Plant Categories"),
      ),
      body: BlocProvider(
        create: (context) => _plantCategoriesBloc,
        child: BlocBuilder<PlantCategoriesBloc, PlantCategoriesState>(
          builder: (context, state) {
            if (state is PlantCategoriesInitial) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PlantCategoriesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PlantCategoriesLoaded) {
              List<PlantCategoryResponse> listCategory = state.listCategories;
              return Container(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  child: ListView(
                    children: listCategory
                        .map((category) => Dismissible(
                              key: Key(category.idCategory),
                              onDismissed: (direction) async {
                                Map<String, dynamic> result = await _apiServices
                                    .deletePlantCategories(category.idCategory);

                                if (result["value"] == 1) {
                                  setState(() {
                                    listCategory.remove(category);
                                  });
                                  showSnackbarMessage(context,
                                      "${category.categoryName} ${result['message']}");
                                }
                              },
                              background: Container(color: Colors.red),
                              child: Card(
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DataByKategory(
                                                  category: category.idCategory,
                                                )));
                                  },
                                  title: Text(category.categoryName),
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.green,
                                    ),
                                    onPressed: () async {
                                      await showBottomBar(category: category);
                                    },
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              );
            } else if (state is PlantCategoriesError) {
              return Center(child: Text('Error'));
            }

            return Center(child: Text('Error'));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showBottomBar();
        },
        child: Icon(
          Icons.keyboard_arrow_up,
          color: Colors.white,
        ),
      ),
    );
  }

  Future showBottomBar({PlantCategoryResponse category}) async {
    bool isEdit = false;
    if (category != null) {
      isEdit = true;
      categoryName.text = category.categoryName;
    }
    _scaffoldKey.currentState.showBottomSheet((context) => Container(
          height: 300,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            boxShadow: [BoxShadow()],
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Category Name",
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: categoryName,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8), gapPadding: 8),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8), gapPadding: 8),
                  ),
                ),
                MaterialButton(
                  minWidth: double.infinity,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: Colors.green,
                  onPressed: () async {
                    print(categoryName.text);
                    if (categoryName.text.isEmpty) {
                      showSnackbarMessage(context, "Data tidak boleh kosong");
                    } else {
                      Map<String, dynamic> result;
                      if (!isEdit) {
                        result = await _apiServices
                            .addPlantCategories(categoryName.text.trim());
                      } else {
                        result = await _apiServices.editPlantCategories(
                            category.idCategory, categoryName.text.trim());
                      }

                      if (result['value'] == 1) {
                        Navigator.pop(context);
                        _plantCategoriesBloc.add(GetPlantCategoriesList());
                        showSnackbarMessage(context, result['message']);
                        categoryName.clear();
                      } else {
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: Text('Simpan'),
                  textColor: Colors.white,
                )
              ],
            ),
          ),
        ));
  }
}
