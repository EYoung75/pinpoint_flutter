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
    // var cool = json.decode(response.body);
    // print("COOL ${cool["results"]}");
  }

  Widget updateResults(place) {
    return FutureBuilder(
      future: getDetails(place),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData) {
          var content = snapshot.data["result"];
          print("DATA$content");
          return Container();
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
