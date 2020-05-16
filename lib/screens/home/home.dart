import 'package:flutter/material.dart';
import 'package:plannusapk/services/auth.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {

  int currentIndex = 0;

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
          backgroundColor: Colors.black54,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
                icon: Icon(Icons.person,
                  color: Colors.yellow,
                ),
                label: Text('logout',
                    style: TextStyle(color: Colors.yellow)
                ),
                onPressed: () async {
                  dynamic result = await auth.googleSignOut();
                  if (result == null)
                    return auth.signOut();
                }
            )
          ],
        ),
          bottomNavigationBar: BottomNavyBar(
            selectedIndex: currentIndex,
            showElevation: true,
            itemCornerRadius: 8,
            curve: Curves.easeInBack,
            onItemSelected: (index) => setState(() {
              print(index);
              currentIndex = index;
            }),
            items: [
              BottomNavyBarItem(
                icon: Icon(Icons.apps),
                title: Text('Home'),
                activeColor: Colors.red,
                textAlign: TextAlign.center,
              ),
              BottomNavyBarItem(
                icon: Icon(Icons.people),
                title: Text('Users'),
                activeColor: Colors.purpleAccent,
                textAlign: TextAlign.center,
              ),
              BottomNavyBarItem(
                icon: Icon(Icons.message),
                title: Text(
                  'Messages',
                ),
                activeColor: Colors.pink,
                textAlign: TextAlign.center,
              ),
              BottomNavyBarItem(
                icon: Icon(Icons.settings),
                title: Text('Settings'),
                activeColor: Colors.blue,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
    }
}
