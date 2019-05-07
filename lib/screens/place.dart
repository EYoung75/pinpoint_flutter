import "package:flutter/material.dart";
import 'package:url_launcher/url_launcher.dart';

class Place extends StatelessWidget {
  final place;
  Place(this.place);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          place["name"],
          style: TextStyle(fontFamily: "Stylish", fontSize: 25),
        ),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/map.png"),
            fit: BoxFit.cover,
          )),
          constraints: BoxConstraints.expand(),
          child: Column(
            children: <Widget>[
              Container(
                height: 300,
                width: 600,
                padding: EdgeInsets.only(top: 45),
                child: Card(
                  elevation: 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        place["name"],
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        place["categories"][0]["name"],
                        style: TextStyle(fontSize: 25),
                      ),
                     SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.star, color: Colors.amber,),
                          Icon(Icons.star, color: Colors.amber,),
                          Icon(Icons.star, color: Colors.amber,),
                          Icon(Icons.star, color: Colors.amber,),
                          Text("  (143)")
                        ],
                      ),
                       SizedBox(
                        height: 20,
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
                      Text("(${place["location"]["distance"].toString()} meters away)"),
                      SizedBox(height: 30,)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 25,),
              RaisedButton(
                color: Colors.redAccent[200],
                textColor: Colors.white,
                elevation: 20,
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
