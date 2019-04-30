import "package:flutter/material.dart";

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
              children: <Widget>[
                Text(place["name"]),
                Text(place["categories"][0]["name"]),
                Text(place["location"]["address"])
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          
        },
        tooltip: "Navigate",
        child: Icon(Icons.navigation, color: Colors.white),
      ),
    );
  }
}
