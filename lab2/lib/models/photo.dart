class Photo{
  final int height;
  final int width;
  final String photo;

  Photo({this.photo,this.height,this.width});

  Photo.fromJson(Map<dynamic,dynamic> parsedJson)
      :height = parsedJson['height'],
      width = parsedJson['width'],
      photo = parsedJson['photo_reference'];
}