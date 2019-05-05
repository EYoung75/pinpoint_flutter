import "package:flutter/material.dart";
import "./screens/landing.dart";

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.deepOrange,
        fontFamily: "Sunflower",
        textTheme: TextTheme(body1: TextStyle(fontSize: 15, fontFamily: "Sunflower"), title: TextStyle(fontFamily: "Stylish", fontSize: 35))
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (BuildContext context) => Landing(),
      }
    );
  }
}