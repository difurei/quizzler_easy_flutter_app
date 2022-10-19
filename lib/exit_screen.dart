import 'package:flutter/material.dart';

class ExitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Center(
            child: Text(
              "So There are no Quiz any more. \n \n Now you can close this App. \n \n Thank\'s for your attention. \n \n Good Luck!!! \n And Be HAPPY ^)",
              style: TextStyle(color: Colors.white, fontSize: 25),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
