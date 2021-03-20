import 'package:flutter/material.dart';
import 'package:parawisata_mutakin/model/plant_model.dart';
import 'package:parawisata_mutakin/network/services.dart';

class Plants extends StatefulWidget {
  @override
  _PlantsState createState() => _PlantsState();
}

class _PlantsState extends State<Plants> {
  ApiServices _apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _apiServices.getDataPlants(),
        builder: (BuildContext context,
            AsyncSnapshot<List<PlantsResponse>> snapshot) {
          if (snapshot.hasData) {
            return buildUIWidget(snapshot.data);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget buildUIWidget(List<PlantsResponse> data) {
    return Container();
  }
}
