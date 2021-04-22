import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lab2/services/auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lab2/services/geolocation.dart';
import 'package:provider/provider.dart';
import 'package:lab2/models/place.dart';
import 'package:lab2/models/comment.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:dio/dio.dart';




class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int sectionIndex = 0;
  
  
  Widget _button(Place place){
      Place placee = Place();
      return RaisedButton(
        splashColor: Theme.of(context).primaryColor,
        highlightColor: Theme.of(context).primaryColor,
        color: Color.fromRGBO(108,63,204,1),
        child: Text(
          'detail',
          style: TextStyle(fontWeight: FontWeight.bold, color:Colors.white, fontSize: 20)          
        ),
        onPressed: (){
            Navigator.pushNamed(
                  context,
                  DetailView.routeName,
                  arguments: DetailData(place)
                    
              );
        },
      );
    }
  
  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position>(context);
    final placeProvider = Provider.of<Future<List<Place>>>(context);
    /*
    var navigationBar = CurvedNavigationBar(
      items: const <Widget>[
        Icon(Icons.fitness_center),
        Icon(Icons.search),
      ],
      index: 0,
      height: 47,
      color: Colors.white.withOpacity(0.5),
      buttonBackgroundColor: Colors.white,
      backgroundColor: Colors.white.withOpacity(0.35),
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 500),
      onTap: (int index) {
        setState(() {
          sectionIndex = index;
        });
      },
    );
  */
    return  FutureProvider(
      create: (context) => placeProvider  ,
      child: Scaffold(
        
        body: (currentPosition != null)
            ? Consumer<List<Place>>(
                builder: (_, places, __) {
                  return Column(
                    children: <Widget>[
                                           
                      Expanded(
                        child: ListView.builder(
                            itemCount: (places != null)?places.length:0,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  title: Row(children: <Widget>[(places[index].icon != null)?Image(
                                  image: NetworkImage(places[index].icon),
                                  height: 30,
                                  width: 30,
                                  ):Row(), Text("    "+places[index].name)],
                                  )    ,
                                  subtitle: Column(children: <Widget>[(places[index].images.length >= 1)?Row(children: <Widget>[Text("\n"),places[index].images[0]],):Row(),(places[index].rating != null)?Row(children: <Widget>[RatingBarIndicator(
                                  rating:places[index].rating ,
                                  itemBuilder: (context, index) =>
                                  Icon(Icons.star,color: Colors.amber),
                                  itemCount: 5,
                                  itemSize: 10.0,
                                  direction:
                                  Axis.horizontal)],): Row(),
                                  (places[index].status != null)?Row(children: <Widget>[Text("status  "+places[index].status)]):Text(""),
                                  Row(children: <Widget>[_button(places[index])])
                                  ],),
                                ),
                              );
                            }),
                      )
                    ],
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      appBar: AppBar(
              backgroundColor: Color.fromRGBO(108,63,204,1),
              title: Text("Program name"),
                          
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      AuthService().logOut();
                    },
                    icon: Icon(
                      Icons.supervised_user_circle,
                      color: Colors.white,
                    ),
                    label: Text("log out"))
              ],
            )
      ),
    );
  }
}



class DetailData {
  final Place place;
  DetailData(this.place);
}

class DetailView extends StatelessWidget {
  static const routeName = '/detail';
 
  void _saveNetworkImage(String url) async {
    
    String savePath = "/storage/emulated/0/Pictures/hello.gif";
    String fileUrl = "https://hyjdoc.oss-cn-beijing.aliyuncs.com/hyj-doc-flutter-demo-run.gif";
    await Dio().download(fileUrl, savePath);
    final result = await ImageGallerySaver.saveFile(savePath);
    print(result);
  }
  @override
  Widget build(BuildContext context) {
    

    final DetailData args =   ModalRoute.of(context).settings.arguments as DetailData;
    if (args == null)
    {
      return Scaffold();
    }
    if(args.place.address == null)
    {
      args.place.address = "-";
    }
     if(args.place.status == null)
    {
      args.place.status = "-";
    }

     if(args.place.phoneNumber == null)
    {
      args.place.phoneNumber = "-";
    }
     if(args.place.website == null)
    {
      args.place.website = "-";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(args.place.name),
        backgroundColor:Color.fromRGBO(108,63,204,1) ,
      ),
      body: ListView.builder(
        itemCount:1,
        itemBuilder: (context, index) {return Column(
        children: <Widget>[
          Container (
                padding: const EdgeInsets.all(16.0),
                width:  MediaQuery.of(context).size.width*0.8,
                child: new Column (
                children: <Widget>[
                    args.place.images[0],
                    Text('\nAdress: '+args.place.address, textAlign: TextAlign.start,style: TextStyle(fontSize: 22)),
                    Text('\nStatus: '+ args.place.status, textAlign: TextAlign.start,style: TextStyle(fontSize: 22)),
                    Text('\nTelephone number:  '+ args.place.phoneNumber, textAlign: TextAlign.start,style: TextStyle(fontSize: 22)),
                    Text('\nWebsite:  '+ args.place.website+"\n", textAlign: TextAlign.start,style: TextStyle(fontSize: 22)),
                  RaisedButton(
          color: Color.fromRGBO(108,63,204,1),
          onPressed: () {
             Navigator.pushNamed(
                  context,
                  MapView.routeName,
                  arguments: MapData(args.place.geometry.location.lat,args.place.geometry.location.lng)
                    
              );
          },
          child: Text('View on Map'),
        ),
        RaisedButton(
          color: Color.fromRGBO(108,63,204,1),
          onPressed: () {
           Navigator.pushNamed(
                  context,
                  CommentView.routeName,
                  arguments: CommentData(args.place.reviews)
           );
          },
          child: Text('Comments'),
        ),
        RaisedButton(
          
          color: Color.fromRGBO(108,63,204,1),
          
          onPressed: () {
          _saveNetworkImage(args.place.photos[0].photo);
          },
          child: Text('get back'),
        ),
                    ],
                  ),
          ),       
        
        
         
        ]
      );
        }
      )
    );
  }
}



class MapData {
  final double lg;
   final double ln;
  MapData(this.lg,this.ln);
}

class MapView extends StatelessWidget {
  static const routeName = '/map';
 
  @override
  Widget build(BuildContext context) {
    

    final MapData args =   ModalRoute.of(context).settings.arguments as MapData;

    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
        backgroundColor:Color.fromRGBO(108,63,204,1)
      ),
      body:Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                              target: LatLng(args.lg,
                                 args.ln),
                              zoom: 18.0),
                          zoomGesturesEnabled: true,
                        ),
                      )
    );
  }
}

class CommentData {
  List<Comment> coment;
  CommentData(this.coment);
}

class CommentView extends StatelessWidget {
  static const routeName = '/comment';
 
  @override
  Widget build(BuildContext context) {
    

    final CommentData args =   ModalRoute.of(context).settings.arguments as CommentData;

    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
        backgroundColor:Color.fromRGBO(108,63,204,1) ,
      ),
      body: ListView.builder(

        itemCount: args.coment.length,
        itemBuilder: (context, index) {
          return  Container(
                        
            child: ListTile(
              
              title: Row(children: <Widget>[(args.coment[index].photo != null)?Image(
              image: NetworkImage(args.coment[index].photo),
              height: 30,
              width: 30,
              ):Row(), Text("    "+args.coment[index].name)], )    ,
              subtitle: Column(children: <Widget>[(args.coment[index].rating != null)?Row(children: <Widget>[RatingBarIndicator(
              rating:args.coment[index].rating.toDouble(),
              itemBuilder: (context, index) =>
              Icon(Icons.star,color: Colors.amber),
              itemCount: 5,
              itemSize: 10.0,
              direction: Axis.horizontal)],): Row(),
              (args.coment[index].text != null)?Row(children: <Widget>[Container (
                padding: const EdgeInsets.all(16.0),
                width:  MediaQuery.of(context).size.width*0.8,
                child: new Column (
                children: <Widget>[
                    new Text (args.coment[index].text)],
                  ),
              )]):Text(""),
             
              ],),
          ),
       );
  })
    );
            
  }
}



