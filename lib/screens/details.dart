import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:resto_finder/screens/restaurent_model.dart';
import 'package:resto_finder/utils.dart';

import '../main.dart';

class Details extends StatefulWidget {
  final Restaurant resto;
  const Details({super.key, required this.resto});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.directions,
              color: Colors.white,
            ),
            Text(
              'Go',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
        shape:
            OutlineInputBorder(borderRadius: BorderRadius.circular(w * 0.08)),
      ),
      body: Padding(
        padding: EdgeInsets.all(w * 0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: h * 0.30,
              width: w,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                      image: AssetImage('Assets/dish1.jfif'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(w * 0.03)),
              child: Padding(
                padding: EdgeInsets.only(top: h * 0.25, left: w * 0.03),
                child: Text(
                  widget.resto.name,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: h * 0.02,
            ),
            Text(
              widget.resto.name,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: w * 0.04),
            ),
            Text(
              widget.resto.neighborhood.name,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Row(
              children: [
                Container(
                  height: h * 0.06,
                  width: w * 0.06,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('Assets/fork.png'),
                          fit: BoxFit.cover)),
                ),
                SizedBox(width: w * 0.02),
                Text(
                  widget.resto.cuisineType,
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                      widget.resto.latlng.lng, widget.resto.latlng.lat),
                  builder: (context, snapshot) {
                    return Text(snapshot.data ?? '');
                  },
                )
              ],
            ),
            SizedBox(
              height: h * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.watch_later_outlined,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: w * 0.03,
                ),
              ],
            ),
            SizedBox(
              height: h * 0.02,
            ),
            Text(
              'Rating & Reviews',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: w * 0.04),
            ),
            SizedBox(
              height: h * 0.01,
            ),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: widget.resto.reviews.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: h * 0.15,
                    width: w,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                                width: w * 0.15,
                                height: h * 0.04,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(w * 0.03),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      widget.resto.reviews[index].rating
                                          .toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.white,
                                    ),
                                  ],
                                )),
                            SizedBox(
                              width: w * 0.01,
                            ),
                            Text(
                              widget.resto.reviews[index].name,
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                        SizedBox(
                          height: h * 0.02,
                        ),
                        SizedBox(
                          height: w * 0.15,
                          child: Text(
                            widget.resto.reviews[index].comments,
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: w * 0.03,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
