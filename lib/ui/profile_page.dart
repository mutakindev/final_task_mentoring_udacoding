import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:parawisata_mutakin/ui/auth/login.dart';
import 'package:parawisata_mutakin/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  logout() async {
    sharedPreferences.clear();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        backgroundColor: Color(0xff00CBA9),
        elevation: 2,
        actions: [
          IconButton(
              color: Colors.black54,
              icon: Icon(Icons.logout),
              onPressed: () async {
                await logout();
              })
        ],
      ),
      body: SingleChildScrollView(
        child: sharedPreferences != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: Color(0xff00CBA9),
                    padding: EdgeInsets.only(top: 24, bottom: 24),
                    child: Column(
                      children: [
                        Hero(
                          tag: 'profileimg',
                          child: Container(
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 8,
                                        blurRadius: 2,
                                        color: Colors.grey.shade300),
                                    BoxShadow(
                                        spreadRadius: 10,
                                        color: Colors.grey.shade200),
                                  ],
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          'https://ui-avatars.com/api/?color=fafafa&background=d91aa0&size=200&name=${sharedPreferences.getString('fullname')}'))),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          sharedPreferences.getString('fullname'),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            alignment: Alignment.bottomCenter,
                            image: AssetImage('assets/images/wave.png'))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.pink.shade400, width: 1))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.person_outline_rounded),
                              SizedBox(width: 10),
                              Text(sharedPreferences.getString('username'),
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 18,
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.pink.shade400, width: 1))),
                          child: Row(
                            children: [
                              Icon(Icons.email_outlined),
                              SizedBox(width: 10),
                              Text(sharedPreferences.getString('email'),
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 18,
                                  )),
                            ],
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: Colors.pink.shade400, width: 1),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.place_outlined),
                                SizedBox(width: 10),
                                Text(sharedPreferences.getString('address'),
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 18,
                                    )),
                              ],
                            )),
                        Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.pink.shade400,
                                        width: 1))),
                            child: Row(
                              children: [
                                Icon(Icons.face_outlined),
                                SizedBox(width: 10),
                                Text(sharedPreferences.getString('sex'),
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 18,
                                    )),
                              ],
                            )),
                      ],
                    ),
                  )
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
