import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parawisata_mutakin/bloc/categories_bloc.dart';
import 'package:parawisata_mutakin/bloc/wisata_bloc.dart';
import 'package:parawisata_mutakin/ui/detail_wisata_page.dart';
import 'package:parawisata_mutakin/model/categories_model.dart';
import 'package:parawisata_mutakin/model/wisata_model.dart';
import 'package:parawisata_mutakin/ui/widgets/custom_appbar.dart';
import 'package:parawisata_mutakin/utils.dart';

class WisataPage extends StatefulWidget {
  @override
  _WisataPageState createState() => _WisataPageState();
}

class _WisataPageState extends State<WisataPage> {
  CarouselController buttonCarouselController = CarouselController();
  final WisataBloc _wisataBloc = WisataBloc();
  int _currentIndex = 1;
  @override
  void initState() {
    super.initState();
    _wisataBloc.add(GetWisataList());
    initSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) => _wisataBloc,
          child: BlocBuilder<WisataBloc, WisataState>(
            builder: (context, state) {
              if (state is WisataInitial) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is WisataLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is WisataLoaded) {
                List<WisataResponse> dataTempatWisata = [];
                dataTempatWisata.addAll(state.listWisata);
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0)
                      .add(EdgeInsets.only(top: 24)),
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            CustomeAppbar(
                                sharedPreferences.getString('fullname')),
                            Text(
                              "Where do\nyou want to go?",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 20),
                            Card(
                              elevation: 2,
                              margin: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: buildCarousel(dataTempatWisata),
                            ),
                            buildCarouselIndicator(dataTempatWisata),
                            SizedBox(height: 8),
                            Categories(dataTempatWisata),
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
                          dataTempatWisata
                              .map((wisata) => Container(
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
                                              blurRadius: 1,
                                              offset: Offset(0, 2),
                                              color: Colors.black
                                                  .withOpacity(0.25))
                                        ]),
                                    child: Material(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                      child: InkWell(
                                        splashColor:
                                            Theme.of(context).accentColor,
                                        borderRadius: BorderRadius.circular(8),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailWisataPage(
                                                        wisata: wisata,
                                                      )));
                                        },
                                        child: Row(children: [
                                          Flexible(
                                            flex: 1,
                                            child: Container(
                                              height: 70,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      offset: Offset(0, 13),
                                                      blurRadius: 10,
                                                      spreadRadius: -8,
                                                      color: Colors.black26,
                                                    )
                                                  ],
                                                  image: DecorationImage(
                                                      image: CachedNetworkImageProvider(
                                                          "$baseWisataImageUrl/${wisata.images.first}"),
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  wisata.title,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  wisata.categoryName,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: Container(
                                              padding: EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.8),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Center(
                                                child: Text(
                                                  "Rp ${wisata.price}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      )
                    ],
                  ),
                );
              } else if (state is WisataError) {
                return Center(child: Text(state.message));
              } else {
                return Container();
              }
            },
          )),
    );
  }

  Row buildCarouselIndicator(List<WisataResponse> dataTempatWisata) {
    return Row(
        children: dataTempatWisata != null
            ? dataTempatWisata.map((value) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == dataTempatWisata.indexOf(value)
                        ? Color.fromRGBO(0, 0, 0, 0.9)
                        : Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                );
              }).toList()
            : []);
  }

  CarouselSlider buildCarousel(List<WisataResponse> dataTempatWisata) {
    return CarouselSlider.builder(
      itemCount: dataTempatWisata != null ? dataTempatWisata.length : null,
      itemBuilder: (BuildContext context, int itemIndex, _) {
        if (dataTempatWisata == null) return null;
        WisataResponse wisata = dataTempatWisata[itemIndex];
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailWisataPage(
                          wisata: wisata,
                        )));
          },
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                        "$baseWisataImageUrl/${wisata.images.first}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                color: Colors.black26,
                width: double.infinity,
              ),
              Align(
                alignment: Alignment(-0.9, 0.9),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    wisata.title,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(
                        "Rp ${wisata.price}",
                        style: TextStyle(
                            color: Colors.white,
                            shadows: [Shadow(blurRadius: 2)]),
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
          onPageChanged: (index, reason) {
            setState(() {
              _currentIndex = index;
            });
          }),
    );
  }
}

class Categories extends StatefulWidget {
  final List<WisataResponse> data;

  Categories(this.data);
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  CategoriesBloc _categoriesBloc = CategoriesBloc();
  List<WisataResponse> filteredList = [];

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
    _categoriesBloc.add(GetCategoriesList());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Categories",
          style: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        BlocProvider(
          create: (context) => _categoriesBloc,
          child: BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesInitial) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CategoriesLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CategoriesLoaded) {
                List<CategoryResponse> listCategory = state.listCategories;
                return Container(
                  height: 50,
                  width: double.infinity,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: listCategory.map((category) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          margin: EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                              left: listCategory.first == category ? 1 : 4,
                              right: 4),
                          decoration: BoxDecoration(
                              color: selectedCategory == category.categoryName
                                  ? Theme.of(context).accentColor
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    offset: Offset(0, 2),
                                    color: Colors.black.withOpacity(0.25))
                              ]),
                          child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            child: InkWell(
                              splashColor: Theme.of(context).accentColor,
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                setState(() {
                                  selectedCategory = category.categoryName;
                                  filterData(category.categoryName);
                                });
                              },
                              child: Center(
                                  child: Text(
                                category.categoryName,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: category.categoryName ==
                                            selectedCategory
                                        ? Colors.white
                                        : Color(0xFF0D0D0B)),
                              )),
                            ),
                          ),
                        );
                      }).toList()),
                );
              } else if (state is CategoriesError) {
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
            height: 200,
            width: double.infinity,
            child: ListView(
                scrollDirection: Axis.horizontal,
                children: filteredList.isNotEmpty
                    ? filteredList.map((wisata) {
                        return Container(
                          margin: EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                              left: wisata == filteredList.first ? 1 : 4,
                              right: 4),
                          height: 200,
                          width: 135,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 2,
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
                                        builder: (context) => DetailWisataPage(
                                              wisata: wisata,
                                            )));
                              },
                              splashColor: Theme.of(context).accentColor,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                boxShadow: [
                                                  BoxShadow(
                                                    offset: Offset(0, 13),
                                                    blurRadius: 10,
                                                    spreadRadius: -8,
                                                    color: Colors.black26,
                                                  )
                                                ],
                                                image: DecorationImage(
                                                    image: CachedNetworkImageProvider(
                                                        "$baseWisataImageUrl/${wisata.images.first}"),
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
                                                  "Rp ${wisata.price}",
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
                                      height: 10,
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            "${wisata.title}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            wisata.categoryName,
                                          ),
                                        ],
                                      ),
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
                          color: Colors.red,
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
