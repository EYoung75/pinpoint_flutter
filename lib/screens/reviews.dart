import "package:flutter/material.dart";


class Reviews extends StatelessWidget {
  final place;
  Reviews(this.place);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${place["name"]} reviews",
          style: TextStyle(fontFamily: "Stylish", fontSize: 25),
        ),
      ),
      body: Container()
      
    );
  }
}