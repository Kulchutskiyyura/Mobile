import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lab2/services/auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lab2/services/geolocation.dart';
import 'package:provider/provider.dart';
import 'package:lab2/models/place.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int sectionIndex = 0;
  
  
  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position>(context);
    final placeProvider = Provider.of<Future<List<Place>>>(context);

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

    return  FutureProvider(
      create: (context) => placeProvider  ,
      child: Scaffold(
        body: (currentPosition != null)
            ? Consumer<List<Place>>(
                builder: (_, places, __) {
                  return Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        width: MediaQuery.of(context).size.width,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                              target: LatLng(currentPosition.latitude,
                                  currentPosition.longitude),
                              zoom: 16.0),
                          zoomGesturesEnabled: true,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: places.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  title: Text(places[index].name),
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
      ),
    );
  }
}