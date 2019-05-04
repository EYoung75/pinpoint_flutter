import 'package:flutter/gestures.dart';
import "package:flutter/material.dart";
import 'package:url_launcher/url_launcher.dart';

class Place extends StatelessWidget {
  final place;
  Place(this.place);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place["name"]),
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints.expand(),
          margin: EdgeInsets.fromLTRB(30, 30, 30, 100),
          child: Card(
            elevation: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                      text: place["name"],
                      style: TextStyle(fontSize: 35, color: Colors.black),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          String query = "${place["location"]["address"]}";
                          String url = "https://maps.google.com/?q=$query";
                          launch("google.com");
                        }),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  place["categories"][0]["name"],
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(place["location"]["address"],
                    style: TextStyle(fontSize: 20)),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
