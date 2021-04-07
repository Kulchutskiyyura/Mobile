import 'package:lab2/models/place.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesService {
  final key = 'AIzaSyAzU3CreMZ1lRkGzqPDjpML_chBNJ6nxz0';

  Future<List<Place>> getPlaces(double lat, double lng) async {
    var response = await http.get('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&type=restaurant&rankby=distance&key=$key');
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    print("response:    ");
    print(response.body);
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }

}