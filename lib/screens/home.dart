import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
import "./results.dart";
import 'package:location/location.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String searchTerm;
  var currentLocation;
  var location = Location();

  void initState() {
    super.initState();
    getLocation();
  }

  Future getLocation() async {  
    location.changeSettings(accuracy: LocationAccuracy.HIGH);
    currentLocation = await location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Enter a keyword")),
      body: Container(
        color: Colors.red,
        padding: EdgeInsets.all(25),
        child: Column(
          children: <Widget>[
            CupertinoTextField(
              autocorrect: true,
              clearButtonMode: OverlayVisibilityMode.editing,
              cursorColor: Colors.greenAccent,
              onChanged: (String value) {
                setState(() {
                  searchTerm = value;
                });
              },
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              placeholder: "Search:",
            ),
            RaisedButton(
              child: Text("Search"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Results(searchTerm, currentLocation)),
                );
              },
              elevation: 5,
            )
          ],
        ),
      ),
    );
  }
}
