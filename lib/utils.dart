import 'dart:convert';

import 'package:geocoding/geocoding.dart';

///for location
Future<String> location(double long,double lat)async{
  List<Placemark> placeMark = await placemarkFromCoordinates(lat, long);

  Placemark place = placeMark[0];

  return "${place.street}, ${place.country}, ${place.isoCountryCode}, ${place.postalCode}";
}


