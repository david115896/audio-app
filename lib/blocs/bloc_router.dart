import 'package:flutter/material.dart';
import 'bloc_musics.dart';
import 'bloc_toupdate.dart';
import './bloc_provider.dart';
import './bloc_user.dart';
import './../intro_view.dart';
import './../views/home.dart';

class BlocRouter {
  BlocProvider startApp() =>
      BlocProvider<BlocUser>(bloc: BlocUser(), child: IntroView());

  MaterialPageRoute homeRoute(BlocUser blocUser) =>
      MaterialPageRoute(builder: (context) => Home(blocUser: blocUser));

  BlocProvider home(BlocUser blocUser) => BlocProvider<BlocToUpdate>(
      bloc: BlocToUpdate(), child: Home(blocUser: blocUser));
}
