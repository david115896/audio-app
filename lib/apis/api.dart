import 'dart:convert';
import './../models/update_model.dart';
import './../models/user_model.dart';
import 'package:http/http.dart' as http;

class Api {
  final _baseUrl = "https://www.citylib.co/";
  String _allCities() => _baseUrl + "cities.json";

  String _connectUser() => _baseUrl + "api/v1/auth/sign_in";
  String _createUser() => _baseUrl + "api/v1/auth";

  Future<List<dynamic>> request(String urlString) async {
    final result = await http.get(urlString);
    final body = json.decode(result.body);
    return body;
  }

  Future<User> connect(String urlString, User user) async {
    //try {
    http.Response responseUser = await http.post(urlString,
        body: json.encode(user.toJson(user)),
        headers: {'Content-type': 'application/json'});

    if (responseUser.statusCode == 200 || responseUser.statusCode == 201) {
      print(responseUser.headers['access-token']);
      print(responseUser.body);
      user = User.fromJson(
          json.decode(responseUser.body), responseUser.headers['access-token']);
      //json.decode(responseUser.headers);
      return user;
      //_trips.add(Trip.fromJson(json.decode(responseNewTrip.body)));
    } else {
      print(responseUser.statusCode);
      print(responseUser.body);
      var error = json.decode(responseUser.body)["errors"][0];
      if (error == "Invalid login credentials. Please try again.") {
        error = "Identifiants incorrects. Merci de ressayer. ";
      }
      user.error = error;
      user.logged = false;
      return user;
    }
    //} catch (e) {
    //  rethrow;
    //}
  }

  Future<User> create(String urlString, User user) async {
    //try {
    http.Response responseUser = await http.post(urlString,
        body: json.encode(user.toJson(user)),
        headers: {'Content-type': 'application/json'});

    if (responseUser.statusCode == 200 || responseUser.statusCode == 201) {
      print(responseUser.headers['access-token']);
      print(responseUser.body);
      user = User.fromJson(
          json.decode(responseUser.body), responseUser.headers['access-token']);
      //json.decode(responseUser.headers);
      return user;
      //_trips.add(Trip.fromJson(json.decode(responseNewTrip.body)));
    } else {
      print(responseUser.statusCode);
      print(responseUser.body);
      var error = json.decode(responseUser.body)["errors"]["full_messages"][0];
      if (error == "Email has already been taken") {
        error = "Cet email est déjà enregistré. Essayez de vous connecter.";
      }
      user.error = error;
      user.logged = false;
      return user;
    }
    //} catch (e) {
    //  rethrow;
    //}
  }

  Future<List<Update>> fetchCities() async {
    final List<dynamic> list = await request(_allCities());
    return list.map((json) => Update.fromJson(json)).toList();
  }

  Future<User> connectUser(User user) async {
    User userConnected = await connect(_connectUser(), user);
    return userConnected;
  }

  Future<User> createUser(User user) async {
    User userCreated = await create(_createUser(), user);
    return userCreated;
  }
}
