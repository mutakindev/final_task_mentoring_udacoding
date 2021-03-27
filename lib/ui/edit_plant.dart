import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parawisata_mutakin/model/plant_categories.dart';
import 'package:parawisata_mutakin/model/plant_model.dart';
import 'package:parawisata_mutakin/network/services.dart';
import 'package:parawisata_mutakin/ui/detail_plant_page.dart';
import 'package:parawisata_mutakin/utils.dart';

class EditPlantPage extends StatefulWidget {
  final PlantsResponse data;
  EditPlantPage(this.data);
  @override
  _EditPlantPageState createState() => _EditPlantPageState();
}

class _EditPlantPageState extends State<EditPlantPage> {
  int categoryId = 0;

  final _plantsRequest = PlantRequest();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _apiService = ApiServices();

  File _image;

  chooseImage() async {
    final imagePicker = ImagePicker();

    var pickedImage = await imagePicker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        _plantsRequest.image = _image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Edit Plant'),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 14),
                        TextFormField(
                          initialValue: widget.data.plantName,
                          validator: (value) => value.isEmpty
                              ? "Silahkan masukan plant name!"
                              : null,
                          onSaved: (plantName) =>
                              _plantsRequest.plantName = plantName,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown)),
                              labelText: "Plant Name"),
                        ),
                        SizedBox(height: 14),
                        TextFormField(
                          initialValue: widget.data.length,
                          keyboardType: TextInputType.number,
                          validator: (value) =>
                              value.isEmpty ? "Silahkan masukan length!" : null,
                          onSaved: (length) => _plantsRequest.length = length,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown)),
                              labelText: "Length"),
                        ),
                        SizedBox(height: 14),
                        TextFormField(
                          initialValue: widget.data.weight,
                          keyboardType: TextInputType.number,
                          validator: (value) =>
                              value.isEmpty ? "Silahkan masukan weight!" : null,
                          onSaved: (weight) => _plantsRequest.weight = weight,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown)),
                              labelText: "Weight"),
                        ),
                        SizedBox(height: 14),
                        TextFormField(
                          initialValue: widget.data.diameter,
                          keyboardType: TextInputType.number,
                          validator: (value) => value.isEmpty
                              ? "Silahkan masukan diameter!"
                              : null,
                          onSaved: (diameter) =>
                              _plantsRequest.diameter = diameter,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown)),
                              labelText: "Diameter"),
                        ),
                        SizedBox(height: 14),
                        TextFormField(
                          initialValue: widget.data.temperatur,
                          keyboardType: TextInputType.number,
                          validator: (value) => value.isEmpty
                              ? "Silahkan masukan temperatur!"
                              : null,
                          onSaved: (temperatur) =>
                              _plantsRequest.temperatur = temperatur,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown)),
                              labelText: "Temperatur"),
                        ),
                        SizedBox(height: 14),
                        TextFormField(
                          initialValue: widget.data.water,
                          validator: (value) =>
                              value.isEmpty ? "Silahkan masukan water!" : null,
                          onSaved: (water) => _plantsRequest.water = water,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown)),
                              labelText: "Water"),
                        ),
                        SizedBox(height: 14),
                        TextFormField(
                          initialValue: widget.data.placement,
                          validator: (value) => value.isEmpty
                              ? "Silahkan masukan placement!"
                              : null,
                          onSaved: (placement) =>
                              _plantsRequest.placement = placement,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown)),
                              labelText: "Placement"),
                        ),
                        SizedBox(height: 14),
                        TextFormField(
                          initialValue: widget.data.information,
                          validator: (value) => value.isEmpty
                              ? "Silahkan masukan information!"
                              : null,
                          onSaved: (information) =>
                              _plantsRequest.information = information,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown)),
                              labelText: "Information"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FutureBuilder(
                          future: _apiService.getPlacementCategories(),
                          // ignore: missing_return
                          builder: (BuildContext context,
                              AsyncSnapshot<List<PlantCategoryResponse>>
                                  snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                height: 30,
                                child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: snapshot.data
                                        .map((e) => Text(
                                            "${e.idCategory} ${e.categoryName} "))
                                        .toList()),
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        ),
                        TextFormField(
                          initialValue: widget.data.category,
                          validator: (value) => value.isEmpty
                              ? "Silahkan masukan category!"
                              : null,
                          keyboardType: TextInputType.number,
                          onSaved: (category) =>
                              _plantsRequest.category = category,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown)),
                              labelText: "Category Id"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Column(
                            children: [
                              _image == null
                                  ? Image.network(
                                      "$basePlantImageUrl/${widget.data.image}")
                                  : Image.file(_image),
                              MaterialButton(
                                onPressed: () async {
                                  chooseImage();
                                },
                                child: Icon(Icons.cloud_upload_outlined),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              try {
                                showSnackbarMessage(context, "Loading....");
                                _plantsRequest.id = widget.data.id;
                                Map<String, dynamic> response =
                                    await _apiService.editPlant(_plantsRequest);
                                if (response != null) {
                                  if (response['value'] == 1) {
                                    showSnackbarMessage(
                                        context, response['message']);
                                    _image = null;
                                    setState(() {});
                                  } else {
                                    showSnackbarMessage(
                                        context, response['message']);
                                  }
                                }
                              } catch (e) {
                                showSnackbarMessage(context, e.toString());
                              }
                            }
                          },
                          child: Text("Submit"),
                          color: Colors.brown,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}