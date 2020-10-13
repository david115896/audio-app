import 'package:flutter/material.dart';
import './../../views/widgets/loader_mini.dart';
import './../../blocs/bloc_user.dart';

class AccountSreen extends StatelessWidget {
  final BlocUser blocUser;
  AccountSreen({this.blocUser});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: blocUser.stream,
      builder: (context, user) {
        if (user.hasData) {
          return Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image:
                                new AssetImage("assets/images/avatar.png")))),
              ),
              SizedBox(height: 40),
              Text(user.data.email != null
                  ? "Mon email: ${user.data.email}"
                  : "Pas d'email"),
              Center(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                        "Merci pour votre soutien dans mon projet, j'aurai besoin de votre retour d'expérience pour améliorer le produit. Envoyez-moi un email à : david@citylib.co")),
              ),
              RaisedButton(
                onPressed: () => blocUser.sendEmail(),
                textColor: Theme.of(context).primaryColor,
                child: Text(
                  "Envoyer un email",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 100),
              RaisedButton(
                onPressed: () => blocUser.logOut(context, blocUser),
                textColor: Theme.of(context).primaryColor,
                child: Text(
                  "Se déconnecter",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          );
        } else {
          return LoaderMini();
        }
      },
    );
  }
}
