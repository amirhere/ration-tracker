import 'package:flutter/material.dart';
import 'widget/home.dart';
import 'widget/login.dart';
import 'widget/dashboard.dart';
import 'widget/addRecord.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {


  final routes = <String,WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    HomePage.tag: (context) => HomePage(),
    Dashboard.tag : (context) => Dashboard(),
    AddRecord.tag : (context) => AddRecord(),

  };




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ration Tracker Login',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nuito'
      ),
      home: LoginPage(),
      routes: routes,
    );
  }
}