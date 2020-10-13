import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: ReadWriteFile(),
    );
  }
}

class ReadWriteFile extends StatefulWidget {
  @override
  _ReadWriteFileAppState createState() => new _ReadWriteFileAppState();
}

class _ReadWriteFileAppState extends State<ReadWriteFile> {
  bool _allowWriteFile = false;

  Future get _localPath async {
    // Application documents directory: /data/user/0/{package_name}/{app_name}
    final applicationDirectory = await getApplicationDocumentsDirectory();

    // External storage directory: /storage/emulated/0
    final externalDirectory = await getExternalStorageDirectory();

    // Application temporary directory: /data/user/0/{package_name}/cache
    final tempDirectory = await getTemporaryDirectory();

    return applicationDirectory.path;
  }

  Future get _localFile async {
    final path = await _localPath;

    return File('$path/filesmetadata.json');
  }

  Future _writeToFile(String text) async {
    if (!_allowWriteFile) {
      return null;
    }

    final file = await _localFile;

    // Write the file
    await file.readAsString();

    File result = await file.writeAsString('$text');

    if (result == null) {
      print("Writing to file failed");
    } else {
      print("Successfully writing to file");

      print("Reading the content of file");
      String readResult = await _readFile();
      print("readResult: " + readResult.toString());
    }
  }

  Future _readFile() async {
    try {
      final file = await _localFile;

      // Read the file
      return await file.readAsString();
    } catch (e) {
      // Return null if we encounter an error
      return null;
    }
  }

  _requestExtStorage() async {
    var status = await Permission.storage.status;
    if (status.isUndetermined) {
      print("permission is " + status.toString());
    }

    if (await Permission.storage.request().isGranted) {
      _allowWriteFile = true;
    }
  }

  @override
  void initState() {
    super.initState();

    _requestExtStorage();
  }

  @override
  Widget build(BuildContext context) {
    this._writeToFile("Test");

    return Scaffold(
        appBar: AppBar(
          title: Text('Writing and Reading File Tutorial'),
        ),
        body: Center(
            child: RaisedButton(
          onPressed: () => _writeToFile("Test"),
          child: Text("clique"),
        )));
  }
}
