import "package:flutter/material.dart";
import "./home.dart";

class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("PinPoint", style: TextStyle(fontFamily: "Stylish", fontSize: 35),)),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("https://assets.simpleviewinc.com/simpleview/image/upload/c_fill,h_645,q_50,w_1024/v1/clients/denver/4f616c91_3217_4da7_807e_ede1e41bf98e_276dbd3a-8822-49ba-9246-41767b077386.jpg"),
              fit: BoxFit.cover,
            )
          ),
          child: Center(
            child: Container(
              constraints: BoxConstraints.expand(),
              child: Card(
                margin: EdgeInsets.fromLTRB(50, 50, 50, 200),
                elevation: 25,
                child: Column(
                  children: <Widget>[
                    ListTile(
                        leading: Icon(
                      Icons.location_on,
                    ),
                    title: Text("PinPoint"),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(40, 20, 40, 45),
                      child: Text(
                        "Click the button below, type in a keyword, and find matching locations closest to you"
                      ),
                    ),
                    RaisedButton(
                      elevation: 10,
                      child: Text("Start Searching"),
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Home()));
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
