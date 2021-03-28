import 'package:flutter/material.dart';
import 'package:lab2/domain/user.dart';

import 'package:lab2/screens/landing.dart';
import 'package:lab2/services/auth.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  //final Future<FirebaseApp> _finapp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
      return StreamProvider<User>.value(
      value: AuthService().currentUser,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Max Fitness',
          theme: ThemeData(
          textTheme: TextTheme(headline6: TextStyle(color: Colors.white))),
          home: LandingPage()),
    );
      // MyHomePage(title: 'Flutter Demo Home Page'),
    }
}

