import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lab2/domain/user.dart';

import 'package:lab2/screens/landing.dart';
import 'package:lab2/screens/home.dart';
import 'package:lab2/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:lab2/services/geolocation.dart';

Future<void> main() async {
  runApp(new MaterialApp(
    home: new MyApp(), 
   
));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  //final Future<FirebaseApp> _finapp = Firebase.initializeApp();
  
  @override
  Widget build(BuildContext context) {
      return StreamProvider<User>.value(
      
      value: AuthService().currentUser,
      child: MaterialApp(
          routes: <String, WidgetBuilder>{'/detail': (BuildContext context) => DetailView()},
                                                          
          debugShowCheckedModeBanner: false,
          title: 'Max Fitness',
          theme: ThemeData(
          textTheme: TextTheme(headline6: TextStyle(color: Colors.white))),
          home: LandingPage()),
    );
      // MyHomePage(title: 'Flutter Demo Home Page'),
    }
}

