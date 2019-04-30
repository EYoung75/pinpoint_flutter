import "package:flutter/material.dart";

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
        title: Text("Results for ${widget.searchTerm}"),
      ),
      body: Center(
        child: Container(
          child: Text("Results"),
        ),
      )
    );
  }

  Future<Map> getResults(String)
}