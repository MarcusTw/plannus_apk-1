import 'package:flutter/material.dart';
import 'package:plannusapk/services/auth.dart';

class Home extends StatelessWidget {

  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: Text('planNUS',
        style: TextStyle(
          color: Colors.amber[800]
        )),
        backgroundColor: Colors.black,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person,
            color: Colors.yellow,
            ),
            label: Text('logout',
              style: TextStyle(color: Colors.yellow)
            ),
            onPressed: () async{
              await auth.signOut();
            },
          )
        ],
      ),
    );
  }
}
