import 'dart:async';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc_router.dart';
import 'bloc.dart';
import '../apis/api.dart';
import './../models/user_model.dart';

class BlocUser extends Bloc {
  User user = User(
    userId: null,
    name: null,
    provider: null,
    uid: null,
    token: null,
    email: null,
    password: null,
    logged: false,
    errorEmail: null,
    errorPassword: null,
    error: null,
    index: 0,
    hide: true,
  );

  final _streamController = StreamController<User>();
  Stream<User> get stream => _streamController.stream;
  Sink<User> get sink => _streamController.sink;

  switchIndex() {
    user.index == 0 ? user.index = 1 : user.index = 0;
    user.error = null;
    sink.add(user);
  }

  updateEmail(String email) {
    user.email = email;
    if (validateEmailAddress(email) == false) {
      user.errorEmail = "Le format ne correspond pas à un email";
    } else {
      user.errorEmail = null;
    }
    if (user.email.length == 0) {
      user.email = null;
    }
    user.error = null;
    sink.add(user);
  }

  sendEmail() async {
    final Email email = Email(
      body: '',
      subject: "Retour d'expérience appli Citylib",
      recipients: ['david@citylib.co'],
      // cc: ['cc@example.com'],
      // bcc: ['bcc@example.com'],
      // attachmentPaths: ['/path/to/attachment.zip'],
      // isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }

  updatePassword(String password) {
    user.password = password;
    if (password.length != 0 && password.length < 6) {
      user.errorPassword = "Minimum 6 caractères";
    } else {
      user.errorPassword = null;
    }
    if (user.password.length == 0) {
      user.password = null;
    }
    user.error = null;
    sink.add(user);
  }

  bool validateEmailAddress(String email) {
    if (email == null) {
      return false;
    }
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  switcHide() {
    user.hide == true ? user.hide = false : user.hide = true;
    user.error = null;
    sink.add(user);
  }

  hideKeyboard(context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  createUser(
    BlocUser blocUser,
    dynamic context,
  ) async {
    hideKeyboard(context);

    if (user.password != null && user.email != null) {
      final userIdentified = await Api().createUser(user);
      if (userIdentified.logged != false) {
        // userIdentified.logged = true;
        sink.add(userIdentified);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userId', userIdentified.userId.toString());
        prefs.setString('email', userIdentified.email);
        prefs.setString('name', userIdentified.name);
        prefs.setString('uid', userIdentified.uid);
        prefs.setString('provider', userIdentified.provider);
        prefs.setString('token', userIdentified.token);
        prefs.setString('admin', userIdentified.admin.toString());
        prefs.setString('logged', userIdentified.logged.toString());
      } else {
        sink.add(userIdentified);
      }
    }
  }

  connectUser(
    BlocUser blocUser,
    BuildContext context,
  ) async {
    hideKeyboard(context);

    if (user.password != null && user.email != null) {
      final userIdentified = await Api().connectUser(user);
      if (userIdentified.logged != false) {
        // userIdentified.logged = true;
        sink.add(userIdentified);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userId', userIdentified.userId.toString());
        prefs.setString('email', userIdentified.email);
        prefs.setString('name', userIdentified.name);
        prefs.setString('uid', userIdentified.uid);
        prefs.setString('provider', userIdentified.provider);
        prefs.setString('token', userIdentified.token);
        prefs.setString('admin', userIdentified.admin.toString());
        prefs.setString('logged', userIdentified.logged.toString());
      } else {
        sink.add(userIdentified);
      }
    }
  }

  checkUserLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int userId = int.parse(
        prefs.getString('userId') != null && prefs.getString('userId') != ""
            ? prefs.getString('userId')
            : "0");
    //final int userId = 0;
    final String email = prefs.getString('email');
    final String name = prefs.getString('name');
    final String uid = prefs.getString('uid');
    final String provider = prefs.getString('provider');
    final String token = prefs.getString('token');
    final bool admin = prefs.getString('admin') == "true" ? true : false;
    // final bool logged = false;
    final bool logged = prefs.getString('logged') == "true" ? true : false;

    if (logged == true) {
      User userLogged = User(
        userId: userId,
        name: name,
        provider: provider,
        uid: uid,
        token: token,
        email: email,
        password: null,
        logged: true,
        errorEmail: null,
        errorPassword: null,
        admin: admin,
        error: null,
        index: 0,
        hide: true,
      );
      sink.add(userLogged);
    } else {
      sink.add(user);
    }
  }

  logOut(BuildContext context, BlocUser blocUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', "");
    prefs.setString('email', "");
    prefs.setString('name', "");
    prefs.setString('uid', "");
    prefs.setString('provider', "");
    prefs.setString('token', "");
    prefs.setString('admin', "");
    prefs.setString('logged', "");

    final newUser = User(
      userId: null,
      name: null,
      provider: null,
      uid: null,
      token: null,
      email: null,
      password: null,
      logged: false,
      errorEmail: null,
      errorPassword: null,
      error: null,
      index: 0,
      hide: true,
    );

    sink.add(newUser);
    Navigator.of(context).push(BlocRouter().homeRoute(blocUser));
  }

  BlocUser() {
    checkUserLogged();
  }

  @override
  void dispose() => _streamController.close();
}
