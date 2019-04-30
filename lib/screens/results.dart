import "package:flutter/material.dart";
import "dart:async";
import "dart:convert";
import "package:http/http.dart" as http;
import "../util/utils.dart" as util;
import "./place.dart";

class Results extends StatefulWidget {
  final String searchTerm;
  Results(this.searchTerm);

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Results for ${widget.searchTerm} near you"),
      ),
      body: Center(
        child: Container(child: updateResults(widget.searchTerm)),
      ),
    );
  }

  Future<Map> getResults(
      String clientId, String clientSecret, String searchTerm) async {
    String apiUrl =
        "https://api.foursquare.com/v2/venues/search?client_id=${util.clientId}&client_secret=${util.clientSecret}&v=20180323&near=Denver,CO&radius=1000&intent=browse&query=$searchTerm";
    http.Response response = await http.get(apiUrl);
    print(json.decode(response.body));
    return json.decode(response.body);
  }

  Widget updateResults(String searchTerm) {
    return FutureBuilder(
      future: getResults(util.clientId, util.clientSecret, searchTerm),
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
        if (snapshot.hasData) {
          var content = snapshot.data["response"]["venues"];
          print("places $content");
          return Container(
            child: ListView.builder(
              itemCount: content.length,
              itemBuilder: (BuildContext context, int index) {
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
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.store),
                                title: Text(content[index]["name"]),
                              ),
                              Text("Tags: ${content[index]["categories"][0]["name"]}"),
                              SizedBox(height: 15,)
                            ],
                          ),
                        ),
                      )),
                );
              },
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
}
