import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:parawisata_mutakin/bloc/plants_bloc.dart';
import 'package:parawisata_mutakin/model/plant_model.dart';
import 'package:parawisata_mutakin/network/services.dart';
import 'package:parawisata_mutakin/ui/plants.dart';
import 'package:parawisata_mutakin/utils.dart';

class DetailPlantPage extends StatelessWidget {
  final PlantsResponse plant;
  ApiServices _apiServices = ApiServices();

  DetailPlantPage({this.plant});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0)
            .add(EdgeInsets.only(top: 24)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          alignment: Alignment.centerLeft,
                          image: plant.image == null
                              ? NetworkImage(
                                  "https://media.giphy.com/media/14uQ3cOFteDaU/giphy.gif")
                              : CachedNetworkImageProvider(
                                  "$basePlantImageUrl/${plant.image}",
                                ),
                          fit: BoxFit.contain),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      margin: EdgeInsets.only(top: 24),
                      padding: EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [BoxShadow(blurRadius: 5)]),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.only(top: 24, right: 16, bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${plant.diameter} cm",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green)),
                              Text("Diameter")
                            ],
                          ),
                          SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${plant.length}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green)),
                              Text("Length")
                            ],
                          ),
                          SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${plant.temperatur} celcius",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green)),
                              Text("Temperatur")
                            ],
                          ),
                          SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${plant.weight}\"",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green)),
                              Text("Weight")
                            ],
                          ),
                          SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${plant.water}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green)),
                              Text("Water")
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          plant.plantName,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          plant.categoryName,
                          style: TextStyle(color: Colors.green.shade300),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                          iconSize: 32,
                          icon: Icon(Icons.delete_outline_rounded,
                              color: Colors.green),
                          onPressed: () async {
                            print(plant.id);
                            showSnackbarMessage(context, "Loading...");
                            Map<String, dynamic> result =
                                await _apiServices.deletePlant(plant.id);

                            if (result != null && result["value"] == 1) {
                              PlantsBloc().add(GetPlantsList());
                              showSnackbarMessage(context,
                                  "${plant.plantName} ${result['message']}");
                              Navigator.pop(context);
                            }
                          }),
                      IconButton(
                          iconSize: 32,
                          icon: Icon(Icons.edit, color: Colors.green),
                          onPressed: () {})
                    ],
                  )
                ],
              ),
              SizedBox(height: 16),
              Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Placement",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      plant.placement,
                      style: TextStyle(
                          color: Colors.grey.shade700, wordSpacing: 1.5),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Information",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      plant.information,
                      style: TextStyle(
                          color: Colors.grey.shade700, wordSpacing: 1.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
