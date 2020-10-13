import 'package:flutter/material.dart';
import './../../../blocs/bloc_user.dart';

class RaisedButtonClicked extends StatelessWidget {
  final String text;
  final BlocUser blocUser;

  RaisedButtonClicked({@required this.text, @required this.blocUser});
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () => blocUser.switchIndex(),
      padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 50.0),
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.white)),
      child: Text(text),
    );
  }
}
