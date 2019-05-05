import "package:flutter/material.dart";
import 'package:latlong/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map/flutter_map.dart';

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
            margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Column(
      children: <Widget>[
        Container(
          height: 200,
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
                      ? Text(place["location"]["address"],
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
          elevation: 10,
          child: Text("Navigate"),
          onPressed: () {
            String query = place["location"]["address"];
            String url = "https://maps.google.com/?q=${query}";
            print(query);
            launch(url);
          },
        ),
        Flexible(
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(56.704173, 11.543808),
                  minZoom: 12.0,
                  maxZoom: 14.0,
                  zoom: 0.0,
                  swPanBoundary: LatLng(56.6877, 11.5089),
                  nePanBoundary: LatLng(56.7378, 11.6644),
                ),
                layers: [
                  TileLayerOptions(
                    offlineMode: true,
                    maxZoom: 14.0,
                    urlTemplate: 'assets/map/anholt_osmbright/{z}/{x}/{y}.png',
                  ),
                ],
              ),
            ),
      ],
            ),
          ),
        ),
    );
  }
}
