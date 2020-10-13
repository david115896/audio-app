import 'package:flutter/material.dart';
import './../../blocs/bloc_router.dart';
import './../../models/user_model.dart';
import './../../blocs/bloc_user.dart';

class MainDrawer extends StatelessWidget {
  final BlocUser blocUser;
  final User user;

  MainDrawer({@required this.blocUser, @required this.user});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.5)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            child: Image.asset("assets/icon/fun_icon.png", fit: BoxFit.contain),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Center(
              child: Text("Accueil"),
            ),
            onTap: () {
              Navigator.of(context).push(BlocRouter().homeRoute(blocUser));
            },
          ),
          Divider(
            height: 10,
            color: Colors.black,
            indent: 10,
            endIndent: 10,
          ),
        ],
      ),
    );
  }
}
