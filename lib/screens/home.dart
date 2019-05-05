import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
import "./results.dart";
import 'package:location/location.dart';

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
      appBar: AppBar(title: Text("Enter a keyword")),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://assets.simpleviewinc.com/simpleview/image/upload/c_fill,h_645,q_50,w_1024/v1/clients/denver/4f616c91_3217_4da7_807e_ede1e41bf98e_276dbd3a-8822-49ba-9246-41767b077386.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(25),
        child: Column(
          children: <Widget>[
            CupertinoTextField(
              autocorrect: true,
              clearButtonMode: OverlayVisibilityMode.editing,
              cursorColor: Colors.greenAccent,
              onChanged: (String value) {
                setState(() {
                  searchTerm = value;
                });
              },
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              placeholder: "Search:",
            ),
            SizedBox(height: 15,),
            RaisedButton(
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              child: Text("Search"),
              onPressed: () {
                if (searchTerm.length <= 2) {
                  return AlertDialog(
                    title: Text(
                        "Please enter a keyword with more than three characters"),
                    actions: <Widget>[RaisedButton(child: Text("close"), onPressed: () {},)],
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Results(searchTerm, currentLocation)),
                  );
                }
              },
              elevation: 5,
            )
          ],
        ),
      ),
    );
  }
}
