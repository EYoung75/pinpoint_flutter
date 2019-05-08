import "package:flutter/material.dart";
import "./home.dart";

class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PinPoint",
            style: TextStyle(fontFamily: "Stylish", fontSize: 30)),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://images.unsplash.com/photo-1456769965965-63334afeaeb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: EdgeInsets.fromLTRB(50, 50, 50, 100),
          child: Card(
            color: Color.fromRGBO(255, 255, 255, .95),
            elevation: 20,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "      PinPoint allows you to enter in a keyword to find matching results closest to you, and displays only the most essential information so you can stop contemplating where to go and start living",
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(height: 20,),
                          Text("Click the button below to start searching", textAlign: TextAlign.center,),
                          Icon(Icons.arrow_downward)
                        ],
                      )),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    },
                    child: Icon(Icons.pin_drop, color: Colors.indigo,),
                    color: Theme.of(context).accentColor,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
