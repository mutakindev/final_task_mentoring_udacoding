import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:parawisata_mutakin/model/plant_model.dart';
import 'package:parawisata_mutakin/network/services.dart';
import 'package:parawisata_mutakin/ui/detail_plant_page.dart';

import '../utils.dart';

class DataByKategory extends StatefulWidget {
  final String category;
  DataByKategory({Key key, this.category}) : super(key: key);

  @override
  _DataByKategoryState createState() => _DataByKategoryState();
}

class _DataByKategoryState extends State<DataByKategory> {
  final ApiServices services = ApiServices();

  Future<List<PlantsResponse>> fetchData() async {
    final result = await services.getDataPlantsByCategory(widget.category);
    if (result != null && result.length > 0) {
      return result;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data By Category"),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder(
        future: fetchData(),
        builder: (BuildContext context,
            AsyncSnapshot<List<PlantsResponse>> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 2, crossAxisSpacing: 2),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext ctx, int i) {
                  var plant = snapshot.data[i];
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 1),
                              color: Colors.black.withOpacity(0.25))
                        ]),
                    child: Material(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPlantPage(
                                plant: plant,
                              ),
                            ),
                          ).then((value) => null);
                        },
                        splashColor: Theme.of(context).accentColor,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                            alignment: Alignment.centerLeft,
                                            image: plant.image == null
                                                ? NetworkImage(
                                                    "https://media.giphy.com/media/14uQ3cOFteDaU/giphy.gif")
                                                : CachedNetworkImageProvider(
                                                    "$basePlantImageUrl/${plant.image}",
                                                  ),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        width: 100,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: Colors.green.shade300,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Center(
                                          child: Text(
                                            "${plant.diameter} CM",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "${plant.plantName}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "${plant.categoryName} Plant",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
