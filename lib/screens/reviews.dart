import "package:flutter/material.dart";

class Reviews extends StatelessWidget {
  final place;
  Reviews(this.place);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "${place["name"]} reviews",
            style: TextStyle(fontFamily: "Stylish", fontSize: 25),
          ),
        ),
        body: ListView.builder(
          itemCount: place["reviews"].length,
          itemBuilder: (BuildContext context, int index) {
            // return Text(place["reviews"][index]["text"]);
            return Card(
                elevation: 10,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Container(
                          height: 50,
                          child: Image.network(
                              place["reviews"][index]["profile_photo_url"])),
                      title: Text(place["reviews"][index]["author_name"], style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
                      trailing: Text(
                          "Rating: ${place["reviews"][index]["rating"].toString()}"),
                    ),
                    Container(
                      padding: EdgeInsets.all(25),
                      child: Text(place["reviews"][index]["text"]),
                    )
                  ],
                ));
          },
        ));
  }
}
