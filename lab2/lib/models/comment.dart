class Comment{
  final String name;
  final String photo;
  final int rating;
  final String text;

  Comment({this.name,this.photo,this.rating,this.text});

  Comment.fromJson(Map<dynamic,dynamic> parsedJson)
      :name = parsedJson['author_name'],
      photo = parsedJson['profile_photo_url'],
      rating = parsedJson['rating'],
      text = parsedJson['text']
      ;
}