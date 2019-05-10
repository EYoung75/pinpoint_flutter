import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import 'package:url_launcher/url_launcher.dart';
import "dart:async";
import "dart:convert";
import "../util/utils.dart" as util;
import "./map.dart";
import "./reviews.dart";

class Place extends StatefulWidget {
  final place;
  Place(this.place);
  @override
  _PlaceState createState() => _PlaceState();
}

class _PlaceState extends State<Place> {
  @override
  Widget build(BuildContext context) {
    var thisPlace = widget.place;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.place["name"],
          style: TextStyle(fontFamily: "Stylish", fontSize: 25),
        ),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[Map(thisPlace), updateCard(thisPlace)],
        ),
      ),
    );
  }

  Future getDetails(place) async {
    String apiUrl =
        "https://maps.googleapis.com/maps/api/place/details/json?placeid=${place["place_id"]}&key=${util.googleMap}";
    http.Response response = await http.get(apiUrl);
    return json.decode(response.body);
  }

  Widget updateCard(thisPlace) {
    return FutureBuilder(
      future: getDetails(thisPlace),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          var content = snapshot.data["result"];
          return _renderContent(content);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _renderContent(content) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            height: 350,
            width: 600,
            margin: EdgeInsets.fromLTRB(20, 45, 20, 0),
            child: Card(
              elevation: 25,
              child: Stack(
                children: <Widget>[
                  _renderCost(content["price_level"]),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    padding: EdgeInsets.all(10),
                    constraints: BoxConstraints.expand(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          content["name"],
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "${content["types"][0].toUpperCase()}",
                              style: TextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Reviews(content)),
                            );
                          },
                          child: Column(
                            children: <Widget>[
                              _renderRatings(content["rating"].round()),
                              Text("${content["rating"].toString()}"),
                              Text(
                                  "(${content["user_ratings_total"].toString()}  ratings)"),
                            ],
                          ),
                        ),
                        Text(
                          content["vicinity"],
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            GestureDetector(
                              child: Icon(Icons.phone_forwarded),
                              onTap: () async {
                                String number =
                                    "tel://${content["formatted_phone_number"]}";
                                launch(number);
                              },
                            ),
                            GestureDetector(
                              child: Icon(Icons.laptop_mac),
                              onTap: () async {
                                String website = "${content["website"]}";
                                launch(website);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          RaisedButton(
            color: Colors.redAccent[200],
            textColor: Colors.white,
            elevation: 25,
            child: Text(
              "Navigate",
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () async {
              String url = "${content["url"]}";
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _renderRatings(var ratings) {
    List<Widget> stars = List<Widget>();
    if (ratings != null) {
      for (var i = .5; i <= ratings; i++) {
        stars.add(
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
        );
      }
      return Row(
        children: stars,
        mainAxisAlignment: MainAxisAlignment.center,
      );
    } else {
      return Text("No Ratings for this location");
    }
  }

  Widget _renderCost(var price) {
    if (price != null) {
      List<Widget> cost = List<Widget>();
      for (var i = 1; i <= price; i++) {
        cost.add(
          Icon(
            Icons.attach_money,
            color: Colors.black,
          ),
        );
      }
      return Container(
        padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
        child: Row(
          children: cost,
        ),
      );
    } else
      return Text("");
  }
}
