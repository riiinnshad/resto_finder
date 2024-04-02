import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:resto_finder/screens/login.dart';
import 'package:resto_finder/screens/restaurent_model.dart';

import 'package:http/http.dart' as http;
import 'package:resto_finder/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'details.dart';
import '../main.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  ///fetching Restuarants
  Future<Restaurants> fetchRestaurants() async {
    var datas;

    final response = await http.get((Uri.parse(
        "https://firstflight-web.ipixsolutions.net/api/getRestaurants")));
    print(response.statusCode);
    print("response.body-------------${response.body}");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);

      datas = Restaurants.fromJson(data);
    } else {
      print("error Failed to Load data");
    }
    return datas;
  }

  List images = [
    "Asset/dish1.jfif",
    "Asset/Delicious Chicken & Goat Cheese dish.jfif",
    "Asset/Cook & Capture Food Styling.jfif",
    "Asset/A classic chicken Marbella recipe.jfif",
    "Asset/dish1.jfif",
    "Asset/Delicious Chicken & Goat Cheese dish.jfif",
    "Asset/Cook & Capture Food Styling.jfif",
    "Asset/dish1.jfif",
    "Asset/Cook & Capture Food Styling.jfif",
    "Asset/A classic chicken Marbella recipe.jfif",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: w * 0.18,
        backgroundColor: Colors.black.withOpacity(0.8),
        title: Text(
          'RESTAURANT',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: w * 0.04),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              print('LOGOUT ----------');
              pref.clear();
              print("loging out");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LogIn(),
                  ));
            },
            child: Container(
              height: h * 0.05,
              width: w * 0.28,
              child: Row(
                children: [
                  Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: w * 0.03,
                  ),
                  Text(
                    'Log Out',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: w * 0.05,
                  )
                ],
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(w * 0.03),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<Restaurants>(
                future: fetchRestaurants(),
                builder: (context, snapshot) {
                  print(snapshot.data);
                  print(snapshot.data?.restaurants);
                  var resto = snapshot.data?.restaurants;
                  return snapshot.connectionState == ConnectionState.waiting &&
                          snapshot.data?.restaurants == null
                      ? Center(child: CircularProgressIndicator())
                      : SizedBox(
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: resto?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Details(resto: resto![index]),
                                      ));
                                },
                                child: Container(
                                  height: h * 0.50,
                                  width: w,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: h * 0.25,
                                        width: w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(w * 0.03),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                  images[index],
                                                ),
                                                fit: BoxFit.cover)),
                                      ),
                                      SizedBox(
                                        height: h * 0.02,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            resto?[index].name ?? "",
                                            style: TextStyle(
                                                fontSize: w * 0.05,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            height: h * 0.04,
                                            width: w * 0.15,
                                            decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        w * 0.08)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  "3.4",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: h * 0.02,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: h * 0.06,
                                            width: w * 0.06,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'Assets/fork.png'),
                                                    fit: BoxFit.cover)),
                                          ),
                                          SizedBox(
                                            width: w * 0.03,
                                          ),
                                          Text(
                                            resto?[index].cuisineType ?? "",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.location_pin,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(
                                            width: w * 0.03,
                                          ),
                                          FutureBuilder(
                                            future: location(
                                                resto![index].latlng.lng,
                                                resto[index].latlng.lat),
                                            builder: (context, snapshot1) {
                                              return Text(
                                                snapshot1.data ?? "",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: w * 0.03),
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
