import 'package:flutter/material.dart';
import './../../../blocs/bloc_user.dart';

class RaisedButtonUnClicked extends StatelessWidget {
  final String text;
  final BlocUser blocUser;

  RaisedButtonUnClicked({@required this.text, @required this.blocUser});
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () => blocUser.switchIndex(),
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
