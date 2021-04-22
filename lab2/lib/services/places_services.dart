import 'package:flutter/cupertino.dart';
import 'package:lab2/models/place.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesService {
  final key = 'AIzaSyAzU3CreMZ1lRkGzqPDjpML_chBNJ6nxz0';

  Future<List<Place>> getPlaces(double lat, double lng) async {
    var response = await http.get('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&type=restaurant&rankby=distance&key=$key');
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    //print("response:   ");
    //print(response);
    List<Place> places = jsonResults.map((place) => Place.fromJsonByLoaction(place)).toList();
    for (var i=0; i<places.length; i++) {
      String id = places[i].placeId;
      print("place id $id");
      var responseById = await http.get('https://maps.googleapis.com/maps/api/place/details/json?place_id=$id&key=$key');
      var jsonById = convert.jsonDecode(responseById.body);
      var jsonResultsById = jsonById['result'];
      places[i].fromJsonById(jsonResultsById);
      if(places[i].photos != null)
      {
        for(int j=0; j<places[i].photos.length;j++)
        {
       
          String ref = places[i].photos[j].photo;
        
        
         // print('https://maps.googleapis.com/maps/api/place/photo?photoreference=$ref&key=$key');
          //Image.network('https://maps.googleapis.com/maps/api/place/photo?maxwidth=300&maxheight=300&photoreference=$ref&key=$key')
          print('https://maps.googleapis.com/maps/api/place/photo?maxwidth=300&maxheight=300&photoreference=$ref&key=$key');
          places[i].images.add( Image.network('https://maps.googleapis.com/maps/api/place/photo?maxwidth=300&maxheight=300&photoreference=$ref&key=$key'));
        }
      }
      //print("second json");
      //print(jsonResultsById);
     
           

  }
    return places;
  }

}