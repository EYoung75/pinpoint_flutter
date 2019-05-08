import "package:flutter/material.dart";
import "dart:async";
import "dart:convert";
import "package:http/http.dart" as http;
import "../util/utils.dart" as util;
import "./place.dart";

class Results extends StatefulWidget {
  final String searchTerm;
  final currentLocation;
  Results(this.searchTerm, this.currentLocation);

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Results for ${widget.searchTerm.toUpperCase()} nearest you", style: TextStyle(fontFamily: "Stylish", fontSize: 20),),
      ),
      body: Center(
        child: Container(
            child: updateResults(widget.searchTerm, widget.currentLocation)),
      ),
    );
  }

  Future<Map> getResults(String clientId, String clientSecret,
      String searchTerm, var currentLocation) async {
    // print("${currentLocation.latitude},${currentLocation.longitude}");
    // print("ACCURACY: ${currentLocation.accuracy}");
    String apiUrl = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=${searchTerm}&key=${util.googleMap}&location=${currentLocation.latitude},${currentLocation.longitude}&radius=5000";
    // print(apiUrl);
    // Below is fetch request from FourSquare API
    // String apiUrl = 
    //     "https://api.foursquare.com/v2/venues/search?client_id=${util.clientId}&client_secret=${util.clientSecret}&v=20180323&ll=${currentLocation.latitude},${currentLocation.longitude}&intent=browse&radius=10000&llAcc=1000.0&query=${searchTerm}";
    http.Response response = await http.get(apiUrl);
    // print(json.decode(response.body));
    return json.decode(response.body);
    // var cool = json.decode(response.body);
    // print("FUCK ${cool["results"]}");
  }

  Widget updateResults(String searchTerm, var currentLocation) {
    return FutureBuilder(
      future: getResults(
          util.clientId, util.clientSecret, searchTerm, currentLocation),
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
        if (snapshot.hasData) {
          var content = snapshot.data["results"];
          print("CONTENTTOOOO ${content}");
          // var content = snapshot.data["response"]["venues"];
          if (content.length <= 0) {
            return Center(
                child: Container(
              child: Text(
                "No results were returned for that keyword. Please try another.",
                textAlign: TextAlign.center,
              ),
            ));
          } else {
            return Container(
              color: Theme.of(context).accentColor,
              child: Column(
                children: <Widget>[
                  Flexible(
                    child: ListView.builder(
                      itemCount: content.length,
                      itemBuilder: (BuildContext context, int index) {
                        if(content[index] == 0 || index > content.length ) { return Text("");}
                        else {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Place(content[index])));
                          },
                          child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 40),
                              child: Center(
                                child: Card(
                                  elevation: 10,
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        // leading: Icon(Icons.restaurant),
                                        leading: Image.network(content[index]["icon"], scale: 3,),
                                        title: Text(content[index]["name"], style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
                                      ),
                                      // commented out widgets were used when utilizing FourSquare data
                                      // Text(
                                      //     "Tags: ${content[index]["categories"][0]["name"]}"),
                                      Text("Tags: ${content[index]["types"][0]}"),
                                      SizedBox(
                                        height: 15,
                                      )
                                    ],
                                  ),
                                ),
                              )),
                        );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
