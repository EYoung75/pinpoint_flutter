import "package:flutter/material.dart";
import 'package:url_launcher/url_launcher.dart';
import "./map.dart";

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
      body: Stack(children: <Widget>[
        Map(place),
        Center(
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
                                Text(place["types"][0],
                                    style: TextStyle(fontSize: 25)),
                              ],
                            ),

                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: <Widget>[
                            //     Icon(
                            //       Icons.star,
                            //       color: Colors.amber,
                            //     ),
                            //     Icon(
                            //       Icons.star,
                            //       color: Colors.amber,
                            //     ),
                            //     Icon(
                            //       Icons.star,
                            //       color: Colors.amber,
                            //     ),
                            //     Icon(
                            //       Icons.star,
                            //       color: Colors.amber,
                            //     ),
                            //     Text(
                            //         "   (${place["user_ratings_total"].toString()})")
                            //   ],
                            // ),
                            renderRatings(place["rating"].round()),
                            Text("${place["rating"].toString()}"),
                            Text(
                                "(${place["user_ratings_total"].toString()}  ratings)"),

                            // GestureDetector(
                            //   onTap: () {
                            //     launch(
                            //         "https://maps.google.com/?q=${place["location"]["address"]}");
                            //   },
                            //   child: place["location"]["address"] != null
                            //       ? Text("${place["location"]["address"]}",
                            //           style: TextStyle(fontSize: 20))
                            //       : Text(
                            //           "The address for this location has not been listed"),
                            // ),
                            // Text(
                            //     "(${place["location"]["distance"].toString()} meters away)"),
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
                  String query = place["location"]["address"];
                  String url = "https://maps.google.com/?q=${query}";
                  print(query);
                  launch(url);
                },
              ),
            ],
          ),
        ),
      ]),
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
      // list.add(Text("  ${place["rating"].toString()}"));
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
      // list.add(Text("  ${place["rating"].toString()}"));
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
