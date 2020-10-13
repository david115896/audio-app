import 'package:flutter/material.dart';
import './blocs/bloc_provider.dart';
import './blocs/bloc_router.dart';
import './blocs/bloc_user.dart';

import './responsive.dart';

class IntroView extends StatefulWidget {
  @override
  _IntroViewState createState() {
    return _IntroViewState();
  }
}

class _IntroViewState extends State<IntroView> {
  @override
  void initState() {
    super.initState();
    final blocUser = BlocProvider.of<BlocUser>(context);

    Future.delayed(
      const Duration(seconds: 2),
      () {
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocRouter().home(blocUser),
              ));
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/icon/fun_icon.png",
                  width: Responsive.screenSize(context) / 2,
                ),
                Text(
                  "Bienvenue dans l'app test",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 50,
                ),
                CircularProgressIndicator(
                  backgroundColor: Colors.white,
                )
              ]),
        ),
      ),
    );
  }
}
