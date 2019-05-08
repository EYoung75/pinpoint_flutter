import "package:flutter/material.dart";
import "dart:async";
import "dart:convert";
import "package:http/http.dart" as http;
import "../util/utils.dart" as util;
import "./map.dart";

class Place extends StatefulWidget {
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
      body: Stack(
        children: <Widget>[
          Map(widget.place),
          updateResults(widget.place)
        ],
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

  Widget updateResults(place) {
    return FutureBuilder(
      future: getDetails(place),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData) {
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
                      // Container(padding: EdgeInsets.all(5), child: Icon(Icons.attach_money)),
                      renderCost(place["price_level"]),
                      Container(
                        decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(3)),
                        padding: EdgeInsets.all(10),
                        constraints: BoxConstraints.expand(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
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

                            // Text(
                            //   place["categories"][0]["name"],
                            //   style: TextStyle(fontSize: 25),
                            // ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("${place["types"][0].toUpperCase()}",
                                    style: TextStyle(fontSize: 25)),
                              ],
                            ),
                            renderRatings(place["rating"].round()),
                            Text("${place["rating"].toString()}"),
                            Text(
                                "(${place["user_ratings_total"].toString()}  ratings)"),
                            Text(
                              place["formatted_address"],
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 30,
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
                onPressed: () {
                  
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
