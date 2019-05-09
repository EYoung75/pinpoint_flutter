import "package:flutter/material.dart";

class Reviews extends StatelessWidget {
  final place;
  Reviews(this.place);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: <Widget>[
            Text(
              "${place["name"]}",
              style: TextStyle(fontFamily: "Stylish", fontSize: 25),
            ),
            Text(
              "at ${place["vicinity"]},",
              style: TextStyle(fontFamily: "Stylish", fontSize: 15),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.indigo[100]),
        child: ListView.builder(
          itemCount: place["reviews"].length,
          itemBuilder: (BuildContext context, int index) {
            // return Text(place["reviews"][index]["text"]);
            return Container(
              margin: EdgeInsets.all(10),
              child: Card(
                elevation: 10,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Container(
                        padding: EdgeInsets.all(5),
                        height: 50,
                        child: Image.network(
                            place["reviews"][index]["profile_photo_url"]),
                      ),
                      title: Text(
                        place["reviews"][index]["author_name"],
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                      trailing: Column(
                        children: <Widget>[
                          Text(
                              "Rating: ${place["reviews"][index]["rating"].toString()}"),
                          SizedBox(
                            height: 5,
                          ),
                          Text(place["reviews"][index]
                              ["relative_time_description"]),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(40),
                      child: Text(
                        "       ${place["reviews"][index]["text"]}", style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.left,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
