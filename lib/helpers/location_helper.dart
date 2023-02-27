import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const API_KEY =
    'pk.eyJ1IjoicmVuZWVuZ2VscyIsImEiOiJja3hxZDIyMmk0cHRpMnJreTVwNzRoYnRlIn0.iY9IPyiIr0Qu4bajDuquEQ';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double? latitude, double? longitude}) {
    return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-l($longitude,$latitude)/$longitude,$latitude,14.25,0,0/600x300?access_token=${API_KEY}';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async{
    final url = Uri.parse('https://api.mapbox.com/geocoding/v5/mapbox.places/$lng,$lat.json?limit=1&access_token=$API_KEY');
    final response = await http.get(url);
    return json.decode(response.body)['features'][0]['place_name'];
  }
}


