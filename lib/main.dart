import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './blocs/bloc_router.dart';

Map<int, Color> color = {
  50: Color.fromRGBO(0, 154, 237, .1),
  100: Color.fromRGBO(0, 154, 237, .2),
  200: Color.fromRGBO(0, 154, 237, .3),
  300: Color.fromRGBO(0, 154, 237, .4),
  400: Color.fromRGBO(0, 154, 237, .5),
  500: Color.fromRGBO(0, 154, 237, .6),
  600: Color.fromRGBO(0, 154, 237, .7),
  700: Color.fromRGBO(0, 154, 237, .8),
  800: Color.fromRGBO(0, 154, 237, .9),
  900: Color.fromRGBO(0, 154, 237, 1),
};

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    MaterialColor colorCustom = MaterialColor(0xFF009AED, color);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Citylib',
      theme: ThemeData(
        primarySwatch: colorCustom, //Colors.blue,
      ),
      home: BlocRouter().startApp(),
    );
  }
}
