import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _handleInput;

  void initState() {
    super.initState();
    _handleInput = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Enter a keyword")),
      body: Container(
        color: Colors.red,
        padding: EdgeInsets.all(25),
        child: Column(
          children: <Widget>[
            CupertinoTextField(
              autocorrect: true,
              clearButtonMode: OverlayVisibilityMode.editing,
              cursorColor: Colors.greenAccent,
              controller: _handleInput,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              placeholder: "Search:",
            ),
            RaisedButton(
              child: Text("Search"),
              onPressed: () {},
              elevation: 5,
            )
          ],
        ),
      ),
    );
  }
}
