import 'package:flutter/material.dart';

class User {
  int userId;
  String name;
  String uid;
  String provider;
  String token;
  String email;
  String password;
  bool admin;
  bool logged;
  bool hide;
  String errorEmail;
  String errorPassword;
  String error;
  int index;

  User({
    @required this.userId,
    @required this.name,
    @required this.uid,
    @required this.provider,
    @required this.token,
    @required this.email,
    @required this.password,
    this.admin,
    this.logged,
    this.errorEmail,
    this.errorPassword,
    this.error,
    this.index,
    this.hide,
  });

  User.fromJson(Map<String, dynamic> jsonUserBody, token)
      : userId = jsonUserBody['data']['id'],
        email = jsonUserBody['data']['email'],
        name = jsonUserBody['data']['first_name'],
        uid = jsonUserBody['data']['uid'],
        logged = true,
        provider = jsonUserBody['data']['provider'],
        token = token;

  Map<String, dynamic> toJson(User user) {
    return {
      'email': user.email,
      'password': user.password,
    };
  }
}
