import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:parawisata_mutakin/model/wisata_model.dart';
import 'package:parawisata_mutakin/utils.dart';

class DetailWisataPage extends StatefulWidget {
  final WisataResponse wisata;

  DetailWisataPage({this.wisata});

  @override
  _DetailWisataPageState createState() => _DetailWisataPageState();
}

class _DetailWisataPageState extends State<DetailWisataPage> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              color: Colors.black26),
                        ],
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              "$baseImageUrl/${widget.wisata.images[selectedImage]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        alignment: Alignment.center,
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [BoxShadow()]),
                        child: IconButton(
                          alignment: Alignment.center,
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.wisata.title,
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  shadows: [Shadow()]),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Rp ${widget.wisata.price}",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  shadows: [Shadow()]),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              children: widget.wisata.images
                                  .map(
                                    (e) => GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedImage =
                                              widget.wisata.images.indexOf(e);
                                        });
                                      },
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          boxShadow: [BoxShadow()],
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: Colors.white38, width: 4),
                                          image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                "$baseImageUrl/$e"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList()),
                        )),
                  ],
                ),
                SizedBox(
                  height: 14,
                ),
                Text(
                  "Overview",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).accentColor),
                ),
                SizedBox(
                  height: 14,
                ),
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 2),
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(1, 2),
                              blurRadius: 5,
                              spreadRadius: 0,
                              color: Colors.black26)
                        ],
                        color: Colors.white,
                      ),
                      child: Center(
                          child: Icon(Icons.timer,
                              color: Theme.of(context).accentColor)),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Duration",
                            style: TextStyle(
                                color: Colors.grey.shade400, fontSize: 14),
                          ),
                          Text(
                            "${widget.wisata.duration}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 5,
                              spreadRadius: 0,
                              color: Colors.black26)
                        ],
                        color: Colors.white,
                      ),
                      child: Center(
                          child: Icon(Icons.star,
                              color: Theme.of(context).accentColor)),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Rating",
                            style: TextStyle(
                                color: Colors.grey.shade400, fontSize: 14),
                          ),
                          Text(
                            "${widget.wisata.rating} out of 5",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 14,
                ),
                Text(
                  widget.wisata.overview,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
