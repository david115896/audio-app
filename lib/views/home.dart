import 'package:flutter/material.dart';
import 'package:test_audio/views/permissions.dart';
import './../views/widgets/loader_mini.dart';
import './../views/widgets/main_drawer.dart';
import './../blocs/bloc_provider.dart';
import './../blocs/bloc_user.dart';
import './../views/widgets/loader.dart';

import './../blocs/bloc_toupdate.dart';

class Home extends StatelessWidget {
  final BlocUser blocUser;

  Home({@required this.blocUser});
  @override
  Widget build(BuildContext context) {
    final blocToUpdate = BlocProvider.of<BlocToUpdate>(context);

    ///Bloc to update

    return StreamBuilder(
        stream: blocUser.stream,
        builder: (context, user) {
          if (user.hasData) {
            return StreamBuilder(
              stream: blocToUpdate.stream,
              builder: (context, toUppates) {
                return Scaffold(
                    appBar: AppBar(
                      title: const Text(
                        "App test",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    drawer: toUppates.hasData
                        ? MainDrawer(
                            blocUser: blocUser,
                            user: user.data,
                          )
                        : Container(),
                    body: toUppates.hasData
                        ? GetPermissions()
                        : Loader(text: "Chargement des donnees ..."));
              },
            );
          } else {
            return LoaderMini();
          }
        });
  }
}
