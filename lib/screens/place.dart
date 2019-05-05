import "package:flutter/material.dart";
import 'package:url_launcher/url_launcher.dart';

class Place extends StatelessWidget {
  final place;
  Place(this.place);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place["name"], style: TextStyle(fontFamily: "Stylish", fontSize: 25),),
      ),
      body: Center(
          child: Container(
            constraints: BoxConstraints.expand(),
            margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("../../assets/map.png"),
              fit: BoxFit.cover,
            )
          ),
          height: 300,
          width: 500,
          padding: EdgeInsets.all(10),
          child: Card(
            elevation: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  place["name"],
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 35,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  place["categories"][0]["name"],
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(
                  height: 35,
                ),
                GestureDetector(
                  onTap: () {
                    launch(
                        "https://maps.google.com/?q=${place["location"]["address"]}");
                  },
                  child: place["location"]["address"] != null
                      ? Text("${place["location"]["address"]}",
                          style: TextStyle(fontSize: 20))
                      : Text(
                          "The address for this location has not been listed"),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
        RaisedButton(
          color: Colors.redAccent[200],
          textColor: Colors.white,
          elevation: 10,
          child: Text("Navigate"),
          onPressed: () {
            String query = place["location"]["address"];
            String url = "https://maps.google.com/?q=${query}";
            print(query);
            launch(url);
          },
        ),
      ],
            ),
          ),
        ),
    );
  }
}
