import "package:flutter/material.dart";
import "dart:async";
import "dart:convert";
import "package:http/http.dart" as http;
import "../util/utils.dart" as util;
import "./map.dart";
import 'package:url_launcher/url_launcher.dart';
import "./reviews.dart";

class Place extends StatefulWidget {
  bool loaded = false;
  final place;
  Place(this.place);
  @override
  _PlaceState createState() => _PlaceState();
}

class _PlaceState extends State<Place> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.place["name"],
          style: TextStyle(fontFamily: "Stylish", fontSize: 25),
        ),
      ),
      body: Center(
        child: widget.loaded == true
            ? CircularProgressIndicator()
            : Stack(
                children: <Widget>[Map(widget.place), updateCard(widget.place)],
              ),
      ),
    );
  }

  Future getDetails(place) async {
    // print("${currentLocation.latitude},${currentLocation.longitude}");
    // print("ACCURACY: ${currentLocation.accuracy}");
    String apiUrl =
        "https://maps.googleapis.com/maps/api/place/details/json?placeid=${place["place_id"]}&key=${util.googleMap}";
    // print(apiUrl);
    // Below is fetch request from FourSquare API
    // String apiUrl =
    //     "https://api.foursquare.com/v2/venues/search?client_id=${util.clientId}&client_secret=${util.clientSecret}&v=20180323&ll=${currentLocation.latitude},${currentLocation.longitude}&intent=browse&radius=10000&llAcc=1000.0&query=${searchTerm}";
    http.Response response = await http.get(apiUrl);
    // print(json.decode(response.body));
    return json.decode(response.body);
  }

  Widget updateCard(place) {
    return FutureBuilder(
      future: getDetails(place),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          var content = snapshot.data["result"];
          print("DATA$content");
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
                        renderCost(content["price_level"]),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(3)),
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
                                  Text("${content["types"][0].toUpperCase()}",
                                      style: TextStyle(fontSize: 25)),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Reviews(content)));
                                },
                                child: Column(
                                  children: <Widget>[
                                    renderRatings(place["rating"].round()),
                                    Text("${content["rating"].toString()}"),
                                    Text(
                                        "(${content["user_ratings_total"].toString()}  ratings)"),
                                  ],
                                ),
                              ),
                              Text(
                                content["vicinity"],
                                textAlign: TextAlign.center,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                  )
                                ],
                              )
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
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget renderRatings(var ratings) {
    List<Widget> stars = List<Widget>();
    if (ratings != null) {
      for (var i = .5; i <= ratings; i++) {
        stars.add(Icon(
          Icons.star,
          color: Colors.amber,
        ));
      }
      return Row(
        children: stars,
        mainAxisAlignment: MainAxisAlignment.center,
      );
    } else {
      return Text("No Ratings for this location");
    }
  }

  Widget renderCost(var price) {
    if (price != null) {
      List<Widget> cost = List<Widget>();
      for (var i = 1; i <= price; i++) {
        cost.add(Icon(
          Icons.attach_money,
          color: Colors.black,
        ));
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
