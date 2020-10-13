import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final String text;

  Loader({this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(text),
          ],
        ),
      ),
    );
  }
}
