import 'package:flutter/material.dart';
import 'package:plannusapk/models/timetable.dart';
import 'package:plannusapk/screens/home/messages.dart';
import 'package:plannusapk/screens/home/profile.dart';
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

  String header = 'Home';

  final tabs = [
    MaterialApp(home:TimeTableWidget(tt: new TimeTable())),
    Scaffold(backgroundColor: Colors.yellow),
    Messages(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: Text(header,
        style: TextStyle(
          color: Colors.white,
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
                await auth.googleSignIn.isSignedIn() ? auth.googleSignOut() : auth.signOut();
              }
          )
        ],
      ),
        body: tabs[currentIndex],
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: currentIndex,
          showElevation: true,
          itemCornerRadius: 8,
          curve: Curves.easeInBack,
          onItemSelected: (index) => setState(() {
            print(index);
            currentIndex = index;
            switch (index) {
            case 0: { header = 'Home'; }
            break;
            case 1: { header = 'Timetable'; }
            break;
            case 2: { header = 'Messages'; }
            break;
            case 3: { header = 'Profile'; }
            break;
          }
          }),
          backgroundColor: Colors.white,
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text('Home'),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text('Timetable'),
            activeColor: Colors.purpleAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.message),
            title: Text('Messages',
            ),
            activeColor: Colors.pink,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.perm_identity),
            title: Text('Profile'),
            activeColor: Colors.blue,
            textAlign: TextAlign.center,
            ),
          ],
        ),
    ),
    );
  }
}
