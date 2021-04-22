import 'package:flutter/cupertino.dart';
import 'package:lab2/models/geometry.dart';
import 'package:lab2/models/comment.dart';
import 'package:lab2/models/photo.dart';

class Place{
  String name;
  double rating;
  int userRatingCount;
  String vicinity;
  String icon;
  Geometry geometry;
  String phoneNumber;
  String website;
  String placeId;
  String status;
  String address;
  List<Comment> reviews;
  List<Photo>  photos;
  List<Image> images;
  

  Place({
    this.geometry, 
    this.name, 
    this.rating, 
    this.userRatingCount,
    this.vicinity, 
    this.icon, 
    this.phoneNumber,
    this.website, 
    this.placeId,
    this.address,
    this.status,
    this.reviews,
    this.photos,
    this.images
    
  });

  Place.fromJsonByLoaction(Map<dynamic, dynamic> parsedJson)
    :name = parsedJson['name'],
    rating = (parsedJson['rating'] !=null) ? parsedJson['rating'].toDouble() : null,
    userRatingCount = (parsedJson['user_ratings_total'] != null) ? parsedJson['user_ratings_total'] : null,
    placeId = parsedJson['place_id'],
    vicinity = parsedJson['vicinity'],
    photos = (parsedJson['photos'] !=null)?(parsedJson["photos"] as List).map((review) => Photo.fromJson(review)).toList(): null,
    status = (parsedJson['opening_hours'] != null) ?(parsedJson['opening_hours'] != null)? (parsedJson['opening_hours']['open_now'])? "open": "close":null :null,
    geometry = Geometry.fromJson(parsedJson['geometry'])
    ;

    
   void fromJsonById(Map<dynamic, dynamic> parsedJson)
   {
    //print(parsedJson);
    images = List<Image>();
    website = (parsedJson['website'] != null) ? parsedJson['website'] : null;
    icon = (parsedJson['icon'] != null) ? parsedJson['icon'] : null;
    phoneNumber = (parsedJson['international_phone_number'] != null) ? parsedJson['international_phone_number'] : null;
    address = (parsedJson['formatted_address'] != null) ? parsedJson['formatted_address'] : null;
    reviews = (parsedJson['reviews'] !=null)?(parsedJson["reviews"] as List).map((review) => Comment.fromJson(review)).toList(): null;
   }
   

}