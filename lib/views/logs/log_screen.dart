import 'package:flutter/material.dart';
import './../../blocs/bloc_user.dart';
import './../../views/widgets/loader_mini.dart';
import './../../views/widgets/logs/raised_button_clicked.dart';
import './../../views/widgets/logs/raised_button_unclicked.dart';

class LogScreen extends StatelessWidget {
  final BlocUser blocUser;

  LogScreen({
    this.blocUser,
  });
  @override
  Widget build(BuildContext context) {
    //final blocIndexLog = BlocProvider.of<BlocIndexLog>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Connexion",
            style: TextStyle(fontSize: 24),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
          child: StreamBuilder(
              stream: blocUser.stream,
              builder: (context, user) {
                if (user.hasData) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              width: 300.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0))),
                              child: user.data.index == 0
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        RaisedButtonClicked(
                                          text: "Connexion",
                                          blocUser: blocUser,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        RaisedButtonUnClicked(
                                          text: "Inscription",
                                          blocUser: blocUser,
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        RaisedButtonUnClicked(
                                          text: "Connexion",
                                          blocUser: blocUser,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        RaisedButtonClicked(
                                          text: "Inscription",
                                          blocUser: blocUser,
                                        ),
                                      ],
                                    )),
                          Container(
                            height: 300,
                            width: 300,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                TextField(
                                    obscureText: false,
                                    decoration: InputDecoration(
                                        hintText: "Saisir un email",
                                        errorText: user.data.errorEmail,
                                        icon: const Padding(
                                            padding: const EdgeInsets.only(
                                                top: 15.0),
                                            child: const Icon(Icons.email))),
                                    onChanged: (email) =>
                                        blocUser.updateEmail(email)),
                                TextField(
                                    obscureText: user.data.hide != null
                                        ? user.data.hide
                                        : true,
                                    decoration: InputDecoration(
                                        errorText: user.data.errorPassword,
                                        hintText: "Saisir un mot de passe",
                                        suffixIcon: IconButton(
                                            icon: Icon(Icons.remove_red_eye),
                                            onPressed: () =>
                                                blocUser.switcHide()),
                                        icon: const Padding(
                                            padding: const EdgeInsets.only(
                                                top: 15.0),
                                            child: const Icon(Icons.lock))),
                                    onChanged: (password) =>
                                        blocUser.updatePassword(password)),
                                SizedBox(height: 20),
                                (user.data.errorPassword == null &&
                                        user.data.password != null &&
                                        user.data.errorEmail == null &&
                                        user.data.email != null)
                                    ? user.data.index == 0
                                        ? RaisedButton(
                                            onPressed: () =>
                                                blocUser.connectUser(
                                              blocUser,
                                              context,
                                            ),
                                            color:
                                                Theme.of(context).primaryColor,
                                            child: Text(
                                              "Se connecter",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )
                                        : RaisedButton(
                                            onPressed: () {
                                              blocUser.createUser(
                                                blocUser,
                                                context,
                                              );
                                            },
                                            color:
                                                Theme.of(context).primaryColor,
                                            child: Text(
                                              "Créer un compte",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )
                                    : user.data.index == 0
                                        ? RaisedButton(
                                            onPressed: null,
                                            color:
                                                Theme.of(context).primaryColor,
                                            child: Text(
                                              "Se connecter",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )
                                        : RaisedButton(
                                            onPressed: null,
                                            color:
                                                Theme.of(context).primaryColor,
                                            child: Text(
                                              "Créer un compte",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )
                              ],
                            ),
                          ),
                          user.data.error != null
                              ? Container(
                                  width: 300,
                                  color: Colors.red,
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    user.data.error,
                                    style: TextStyle(color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ))
                              : Container(),
                        ],
                      ),
                    ],
                  );
                } else {
                  return LoaderMini();
                }
              }),
        ));
  }
}
