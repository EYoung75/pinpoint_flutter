import "package:flutter/material.dart";
import "dart:async";
import "dart:convert";
import "package:http/http.dart" as http;
import "../util/utils.dart" as util;
import "./placeTwo.dart";

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
        title: Text(
          "Results for ${widget.searchTerm.toUpperCase()} nearest you",
          style: TextStyle(fontFamily: "Stylish", fontSize: 20),
        ),
      ),
      body: Center(
        child: Container(
          child: updateResults(widget.searchTerm, widget.currentLocation),
        ),
      ),
    );
  }

  Future<Map> getResults(String searchTerm, var currentLocation) async {
    String apiUrl =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?query=${searchTerm}&key=${util.googleMap}&location=${currentLocation.latitude},${currentLocation.longitude}&rankby=distance";
    http.Response response = await http.get(apiUrl);
    return json.decode(response.body);
  }

  Widget updateResults(String searchTerm, var currentLocation) {
    return FutureBuilder(
      future: getResults(searchTerm, currentLocation),
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
        if (snapshot.hasData) {
          var content = snapshot.data["results"];
          if (content.length <= 0) {
            return _noResults();
          } else {
            return _results(content);
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _noResults() {
    return Center(
              child: Container(
                margin: EdgeInsets.all(15),
                child: Text(
                  "No results were returned for that keyword. Check your spelling and try again.",
                  textAlign: TextAlign.center,
                ),
              ),
            );
  }

  Widget _results(content) {
    return Container(
              color: Theme.of(context).accentColor,
              child: Column(
                children: <Widget>[
                  Flexible(
                    child: ListView.builder(
                      itemCount: content.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (content[index] == 0 || index > content.length) {
                          return Text("");
                        } else {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Place(content[index]),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 40),
                              child: Center(
                                child: Card(
                                  elevation: 10,
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        leading: Image.network(
                                          content[index]["icon"],
                                          scale: 3,
                                        ),
                                        title: Text(
                                          content[index]["name"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 25,
                                          ),
                                          _renderIfOpen(content[index]),
                                          Spacer(),
                                          Text(
                                            "Tags:",
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline),
                                          ),
                                          Text(
                                              "   ${content[index]["types"][0]}"),
                                          SizedBox(
                                            width: 25,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
  }


  Widget _renderIfOpen(open) {
    if (open["opening_hours"] == null) {
      return Text("");
    } else {
      if (open["opening_hours"]["open_now"] == true) {
        return Text(
          "open now",
          style: TextStyle(color: Colors.green),
        );
      } else if (open["opening_hours"]["open_now"] == null) {
        return Text("");
      } else {
        return Text(
          "closed",
          style: TextStyle(color: Colors.red),
        );
      }
    }
  }
}
