import "package:flutter/material.dart";
import "./screens/landing.dart";
import "./screens/home.dart";

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
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.blueGrey[300],
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (BuildContext context) => Landing(),
      }
    );
  }
}