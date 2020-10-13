import 'package:flutter/material.dart';
import 'splashpage.dart';
import 'package:permission_handler/permission_handler.dart';

class GetPermissions extends StatefulWidget {
  @override
  GetPermissionsState createState() => GetPermissionsState();
}

class GetPermissionsState extends State<GetPermissions> {
  _requestExtStorage() async {
    var status = await Permission.storage.status;
    if (status.isUndetermined) {
      print("permission is " + status.toString());
    }

    if (await Permission.storage.request().isGranted) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SplashScreen()));
    }
  }

  @override
  void initState() {
    _requestExtStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/icon/fun_icon.png"),
      ),
    );
  }
}
