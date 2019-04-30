import "package:flutter/material.dart";
import "dart:async";
import "dart:convert";
import "package:http/http.dart" as http;
import "../util/utils.dart" as util;

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
                  onTap: () {},
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Center(
                        child: Card(
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.my_location),
                                title: Text(content[index]["name"]),
                              ),
                              Text(content[index]["categories"][0]["name"])
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
