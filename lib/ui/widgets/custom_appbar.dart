import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:parawisata_mutakin/ui/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomeAppbar extends StatelessWidget {
  String name;
  CustomeAppbar(this.name);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25))],
                  color: Colors.white),
              padding: EdgeInsets.all(3),
              child: Hero(
                tag: 'profileimg',
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            'https://ui-avatars.com/api/?color=fafafa&background=d91aa0&size=200&name=$name}')),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          Text(
            "Hi, $name",
            style: Theme.of(context)
                .textTheme
                .subtitle2
                .copyWith(fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
