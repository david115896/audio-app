import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:test_audio/views/homepage.dart';
import 'dart:async';
import 'musicplayer.dart' as musicplayer;
import 'home.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  Future<Directory> extDir;
  Directory extDir2;
  String kUrl;
  Uint8List image1;
  RegExp exp = RegExp(r"^([^\/]+)");
  static const platform = const MethodChannel('demo.janhrastnik.com/info');
  var path;
  String loadingTrack;
  double loadingTrackNumber = 0.0;
  String sdCard;

  // used for app
  List _metaData = [];
  List _musicFiles = [];

  // used for json file
  Map mapMetaData = Map();

  void updateLoadingTrack(track, number, size) {
    setState(() {
      loadingTrack = track;
      loadingTrackNumber = number / size;
    });
  }

  Future<File> writeStoredMetaData(Map fileMetaData) async {
    final file = await _localFile;
    var jsonData = jsonEncode(fileMetaData);
    // Write the file
    return file.writeAsString(jsonData);
  }

  Future<File> writeImage(var hash, List<int> image) async {
    File imagefile = File('$path/$hash');
    return imagefile.writeAsBytes(image);
  }

  void wrap() async {
    path = await _localPath;
    musicplayer.appPath = path;
    await getFiles();
    await _getAllMetaData();
    for (var i = 0; i < _musicFiles.length; i++) {
      if (_metaData[i][0] == null) {
        String s = _musicFiles[i];
        for (var n = s.length; n > 0; n--) {
          if (s.substring(n - 2, n - 1) == "/") {
            _metaData[i][0] = s.substring(n - 1, s.length - 4);
            break;
          }
        }
        if (_metaData[i][1] == null) {
          _metaData[i][1] = "Unknown Artist";
        }
        if (_metaData[i][3] == null) {
          _metaData[i][3] = "Unknown Album";
        }
      }
      if (_metaData[i][4] != null) {
        Iterable<Match> matches = exp.allMatches(_metaData[i][4]);
        for (Match match in matches) {
          _metaData[i][4] = match.group(0);
        }
      } else {
        _metaData[i][4] = "0";
      }
    }

    for (var i = 0; i < _musicFiles.length; i++) {
      mapMetaData[_musicFiles[i]] = _metaData[i];
    }
    writeStoredMetaData(mapMetaData);
    musicplayer.allMetaData = _metaData;
    musicplayer.allFilePaths = _musicFiles;
    onDoneLoading();
  }

  void getFiles() async {
    await _getSdCard().then((data) {
      sdCard = data;
    });
    await getExternalStorageDirectory().then((data) {
      extDir2 = data;
      if (_musicFiles.isEmpty == true) {
        var mainDir = Directory(extDir2.path);
        List contents = mainDir.listSync(recursive: true);
        for (var fileOrDir in contents) {
          if (fileOrDir.path.toString().endsWith(".mp3")) {
            _musicFiles.add(fileOrDir.path);
          }
        } // tries to find external sd card
      } else {}
    });
    try {
      await runStream();
    } catch (e) {
      print(e);
    }
  }

  pass() {
    return null;
  }

  Future _getAllMetaData() async {
    for (var track in _musicFiles) {
      var data = await _getFileMetaData(track);
      updateLoadingTrack(track, _musicFiles.indexOf(track), _musicFiles.length);
      print(track);
      print(_musicFiles.indexOf(track));
      if (data != null && data[2] != null) {
        if (data[2] is List<int>) {
          var digest = sha1.convert(data[2]).toString();
          writeImage(digest, data[2]);
          data[2] = digest;
          _metaData.add(data);
        } else {
          _metaData.add(data);
        }
      } else {
        _metaData.add(data);
      }
    }
  }

  Future _getFileMetaData(track) async {
    var value;
    try {
      if (mapMetaData != null && mapMetaData[track] == null) {
        value = await platform
            .invokeMethod("getMetaData", <String, dynamic>{'filepath': track});
      } else {
        value = mapMetaData[track];
      }
    } catch (e) {
      print(e);
    }
    return value;
  }

  Future _getSdCard() async {
    var value;
    try {
      value = await platform.invokeMethod("getSdCardPath");
    } catch (e) {
      print(e);
    }
    return value;
  }

  runStream() async {
    String sdCardDir = Directory(sdCard).parent.parent.parent.parent.path;
    var extSdDir = Directory(sdCardDir);
    Stream sdContents = extSdDir.list(recursive: true);
    sdContents = sdContents.handleError((data) {});
    await for (var data in sdContents) {
      if (data.path.endsWith(".mp3")) {
        _musicFiles.add(data.path);
      }
    }
  }

  onDoneLoading() async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  }

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

  Future readStoredMetaData() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();
      return jsonDecode(contents);
    } catch (e) {
      print(e);
      // If encountering an error, return 0
      return 0;
    }
  }

  @override
  void initState() {
    super.initState();
    readStoredMetaData().then((data) {
      if (data != 0) {
        mapMetaData = data;
      }
      wrap();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.asset("assets/images/icon3-192.png"),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                ),
              ),
              Container(
                width: 800.0,
                height: 100.0,
                child: Center(
                  child: Text("Loading track: $loadingTrack"),
                ),
              ),
              LinearProgressIndicator(
                value: loadingTrackNumber,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
