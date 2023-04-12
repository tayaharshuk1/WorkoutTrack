import 'dart:async';

import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return initScreen(context);
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 3);
    return new Timer(duration, route);
  }

  route() {
    int count = 0;
    Navigator.of(context).popUntil((_) => count++ >= 2);
  }

  initScreen(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue, Colors.red,],
            )
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 30),
            Padding(padding: EdgeInsets.only(top: 50.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("You have registered successfully!",
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              "Signing in...",
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.white
              ),
            ),
            SizedBox(height: 50),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 3,
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}