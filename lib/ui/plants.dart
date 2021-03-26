import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parawisata_mutakin/bloc/plant_categories_bloc.dart';
import 'package:parawisata_mutakin/bloc/plants_bloc.dart';
import 'package:parawisata_mutakin/model/plant_categories.dart';
import 'package:parawisata_mutakin/model/plant_model.dart';
import 'package:parawisata_mutakin/network/services.dart';
import 'package:parawisata_mutakin/ui/add_plant.dart';
import 'package:parawisata_mutakin/ui/categories_page.dart';
import 'package:parawisata_mutakin/ui/detail_plant_page.dart';
import 'package:parawisata_mutakin/utils.dart';

class Plants extends StatefulWidget {
  @override
  _PlantsState createState() => _PlantsState();
}

class _PlantsState extends State<Plants> {
  ApiServices _apiServices = ApiServices();
  PlantsBloc _plantsBloc = PlantsBloc();
  CarouselController buttonCarouselController = CarouselController();
  static PlantCategoriesBloc plantCategoriesBloc = PlantCategoriesBloc();

  @override
  void initState() {
    super.initState();
    _plantsBloc.add(GetPlantsList());
    plantCategoriesBloc.add(GetPlantCategoriesList());
  }

  refreshData() {
    _plantsBloc.add(GetPlantsList());
    plantCategoriesBloc.add(GetPlantCategoriesList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () {
            refreshData();
            return Future.delayed(Duration(seconds: 2));
          },
          child: BlocProvider(
              create: (context) => _plantsBloc,
              child: BlocBuilder<PlantsBloc, PlantsState>(
                // ignore: missing_return
                builder: (context, state) {
                  if (state is PlantsInitial) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PlantsLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PlantsLoaded) {
                    return buildUIWidget(state.listPlants);
                  } else if (state is PlantsError) {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                },
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        elevation: 2,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPlantPage()));
        },
      ),
    );
  }

  Widget buildUIWidget(List<PlantsResponse> data) {
    return Container(
      margin: EdgeInsets.all(14),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                buildCustomeAppBar(),
                Row(
                  children: [
                    Text(
                      "Welcome",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    Image.network(
                      "https://e7.pngegg.com/pngimages/105/141/png-clipart-cactaceae-encapsulated-postscript-cactus-background-cactaceae-plant-stem.png",
                      width: 35,
                      height: 35,
                    )
                  ],
                ),
                SizedBox(height: 20),
                buildCarousel(data),
                // buildCarouselIndicator(data),
                SizedBox(height: 16),
                Categories(data, plantCategoriesBloc),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Popular",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              data
                  .map((plant) => Container(
                        margin: EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                        ),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 1),
                                  color: Colors.black.withOpacity(0.25))
                            ]),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          child: InkWell(
                            splashColor: Theme.of(context).accentColor,
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailPlantPage(
                                            plant: plant,
                                          )));
                            },
                            child: Row(children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                          image: plant.image == null
                                              ? NetworkImage(
                                                  "https://media.giphy.com/media/14uQ3cOFteDaU/giphy.gif")
                                              : CachedNetworkImageProvider(
                                                  "$basePlantImageUrl/${plant.image}",
                                                ),
                                          fit: BoxFit.cover)),
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Flexible(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      plant.plantName,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      plant.categoryName,
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(plant.diameter + ' cm',
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.w600)),
                                      SizedBox(height: 5),
                                      Text("${plant.weight} KG",
                                          style: TextStyle(
                                              color: Colors.green.shade400,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  )),
                            ]),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          SliverGrid(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                final plant = data[index];
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
                                    )));
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
              }, childCount: data.length),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5)),
        ],
      ),
    );
  }

  buildCustomeAppBar() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25))],
                color: Colors.white),
            padding: EdgeInsets.all(3),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: AssetImage("assets/images/profile.png")),
              ),
            ),
          ),
          SizedBox(width: 8),
          Text(
            "Hi, Mutakin",
            style: Theme.of(context)
                .textTheme
                .subtitle2
                .copyWith(fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  buildCarousel(List<PlantsResponse> dataPlants) {
    return CarouselSlider.builder(
      itemCount: dataPlants != null ? dataPlants.length : null,
      itemBuilder: (BuildContext context, int itemIndex, _) {
        if (dataPlants == null) return null;
        PlantsResponse plant = dataPlants[itemIndex];
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailPlantPage(
                          plant: plant,
                        )));
          },
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                      image: plant.image == null
                          ? NetworkImage(
                              "https://media.giphy.com/media/14uQ3cOFteDaU/giphy.gif")
                          : CachedNetworkImageProvider(
                              "$basePlantImageUrl/${plant.image}",
                            ),
                      fit: BoxFit.contain,
                      alignment: Alignment.centerLeft),
                ),
              ),
              Align(
                alignment: Alignment(0.9, 0.9),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    plant.plantName,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.black45, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 150,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.green.shade300,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(
                        "Diameter ${plant.diameter}cm",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
      carouselController: buttonCarouselController,
      options: CarouselOptions(
        autoPlay: true,
        viewportFraction: 1.0,
        aspectRatio: 2.0,
        height: 145,
        initialPage: 1,
      ),
    );
  }
}

class Categories extends StatefulWidget {
  final List<PlantsResponse> data;
  PlantCategoriesBloc _plantCategoriesBloc;

  Categories(this.data, this._plantCategoriesBloc);
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<PlantsResponse> filteredList = [];

  var selectedCategory = "";

  filterData(String query) {
    filteredList.clear();
    filteredList
        .addAll(widget.data.where((element) => element.categoryName == query));
  }

  @override
  void initState() {
    super.initState();
    filteredList.addAll(widget.data);
  }

  @override
  void dispose() {
    super.dispose();
    widget._plantCategoriesBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Categories",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CategoryPage()));
                },
                child: Text(
                  "Lihat Semua",
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(color: Colors.green),
                ))
          ],
        ),
        BlocProvider(
          create: (context) => widget._plantCategoriesBloc,
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
                  height: 40,
                  width: double.infinity,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: listCategory.map((category) {
                        return Container(
                          margin: EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                              left: listCategory.first == category ? 1 : 4,
                              right: 4),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              setState(() {
                                selectedCategory = category.categoryName;
                                filterData(category.categoryName);
                              });
                            },
                            child: Center(
                                child: Column(
                              children: [
                                Text(
                                  category.categoryName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: selectedCategory ==
                                              category.categoryName
                                          ? Color(0xFF0D0D0B)
                                          : Colors.grey.shade400),
                                ),
                                SizedBox(height: 3),
                                selectedCategory == category.categoryName
                                    ? Container(
                                        width: 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: selectedCategory ==
                                                    category.categoryName
                                                ? Colors.green
                                                : Colors.grey.shade400,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: selectedCategory ==
                                                          category.categoryName
                                                      ? Colors.green
                                                      : Colors.grey.shade400,
                                                  blurRadius: 3)
                                            ]),
                                      )
                                    : Container()
                              ],
                            )),
                          ),
                        );
                      }).toList()),
                );
              } else if (state is PlantCategoriesError) {
                return Center(child: Text('Error'));
              }

              return Center(child: Text('Error'));
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
            height: 250,
            width: double.infinity,
            child: ListView(
                scrollDirection: Axis.horizontal,
                children: filteredList.isNotEmpty
                    ? filteredList.map((plant) {
                        return Container(
                          margin: EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                              left: plant == filteredList.first ? 1 : 8,
                              right: 8),
                          width: 200,
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
                                            )));
                              },
                              splashColor: Theme.of(context).accentColor,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                image: DecorationImage(
                                                    image: plant.image == null
                                                        ? NetworkImage(
                                                            "https://media.giphy.com/media/14uQ3cOFteDaU/giphy.gif")
                                                        : CachedNetworkImageProvider(
                                                            "$basePlantImageUrl/${plant.image}",
                                                          ),
                                                    fit: BoxFit.cover)),
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Container(
                                              width: 100,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade400
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Center(
                                                child: Text(
                                                  "${plant.diameter} CM",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      shadows: [
                                                        Shadow(blurRadius: 2)
                                                      ]),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
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
                      }).toList()
                    : [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:
                                "https://media.giphy.com/media/14uQ3cOFteDaU/giphy.gif",
                          ),
                        )
                      ])),
      ],
    );
  }
}
