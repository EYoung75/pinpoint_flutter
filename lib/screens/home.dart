import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
import 'package:location/location.dart';
import "package:animator/animator.dart";
import "./results.dart";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String searchTerm;
  var currentLocation;
  var location = Location();

  void initState() {
    super.initState();
    getLocation();
  }

  Future getLocation() async {
    await location.changeSettings(accuracy: LocationAccuracy.HIGH);
    currentLocation = await location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Enter a keyword",
          style: TextStyle(fontFamily: "Stylish", fontSize: 30),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://images.unsplash.com/photo-1534298261662-f8fdd25317db?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(25),
        child: Column(
          children: <Widget>[
            CupertinoTextField(
              autocorrect: true,
              clearButtonMode: OverlayVisibilityMode.editing,
              onChanged: (String value) {
                setState(() {
                  searchTerm = value;
                });
              },
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              placeholder: "Search:",
            ),
            SizedBox(
              height: 15,
            ),
            RaisedButton(
              color: Colors.redAccent[200],
              textColor: Colors.white,
              elevation: 5,
              child: Animator(
                tween: Tween<double>(begin: 0, end: 3 * 3.14),
                curve: Curves.elasticIn,
                cycles: 100,
                duration: Duration(seconds: 3),
                builder: (anim) => Transform.rotate(
                      angle: anim.value,
                      child: Icon(Icons.arrow_forward),
                    ),
              ),
              onPressed: () {
                if (searchTerm.length <= 2) {
                  // Render Alert Dialog or similar widget to catch too short of input
                  return Container();
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Results(searchTerm, currentLocation),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
