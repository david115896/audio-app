import 'package:flutter/material.dart';
import './../../blocs/bloc_user.dart';
import './../../views/logs/account_screen.dart';
import './../../views/widgets/main_drawer.dart';
import './../../views/widgets/loader.dart';

class MyAccount extends StatelessWidget {
  final BlocUser blocUser;

  MyAccount({@required this.blocUser});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Mon compte",
            style: TextStyle(fontSize: 24),
          ),
        ),
        drawer: StreamBuilder(
            stream: blocUser.stream,
            builder: (context, user) {
              if (user.hasData) {
                return MainDrawer(
                  blocUser: blocUser,
                  user: user.data,
                );
              } else {
                return Loader(text: "Chargement de votre compte ...");
              }
            }),
        body: AccountSreen(blocUser: blocUser));
  }
}
