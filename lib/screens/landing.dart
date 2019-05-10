import "package:flutter/material.dart";
import "package:animator/animator.dart";
import "./home.dart";

class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PinPoint",
          style: TextStyle(fontFamily: "Stylish", fontSize: 30),
        ),
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
          margin: EdgeInsets.all(50),
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
                          "Welcome to PinPoint",
                          style: TextStyle(fontSize: 35),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "     It's simple. Enter in a keyword to find nearby points of interest that closely match your keyword. Only the most essential information for each place is provided so you spend less time contemplating where to go and more time living.",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Click the button below to start searching",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Animator(
                          tween: Tween<Offset>(
                            begin: Offset(0, 0),
                            end: Offset(0, -.5),
                          ),
                          cycles: 100,
                          duration: Duration(seconds: 1),
                          builder: (anim) => FractionalTranslation(
                                translation: anim.value,
                                child: Icon(Icons.arrow_downward),
                              ),
                        )
                      ],
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                    child: Icon(
                      Icons.pin_drop,
                      color: Colors.indigo,
                    ),
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
