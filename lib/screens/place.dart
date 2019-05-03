import "package:flutter/material.dart";
import 'package:url_launcher/url_launcher.dart';

class Place extends StatelessWidget {
  final place;
  Place(this.place);

  _launchURL() async {
    String query = place["location"]["address"];
    print(query);
    // String url = "https://maps.google.com/?q=${query}";
    String url = "google.com";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
                Text(
                  place["name"],
                  style: TextStyle(fontSize: 35),
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
      floatingActionButton: FloatingActionButton(
        onPressed: _launchURL,
        tooltip: "Navigate",
        child: Icon(Icons.navigation, color: Colors.white),
      ),
    );
  }
}
