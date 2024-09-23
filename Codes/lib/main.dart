import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:se_app/allscreens/loginscreen.dart';
import 'package:se_app/allscreens/mainscreen.dart';
import 'package:se_app/allscreens/registerationscreen.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

DatabaseReference usersRef = FirebaseDatabase.instance.reference().child("users");

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EAS App',
      theme: ThemeData(
        fontFamily: "Signatra",
        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: loginscreen.idscreen,
      routes: {
        registerationscreen.idscreen: (context) => registerationscreen(),
        loginscreen.idscreen: (context) => loginscreen(),
        mainscreen.idscreen: (context) => mainscreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

