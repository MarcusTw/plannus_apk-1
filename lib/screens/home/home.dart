import 'package:flutter/material.dart';
import 'package:plannusapk/models/day_schedule.dart';
import 'package:plannusapk/models/timetable.dart';
import 'package:plannusapk/models/user.dart';
import 'package:plannusapk/models/weekly_event_adder.dart';
import 'package:plannusapk/screens/home/messages.dart';
import 'package:plannusapk/screens/home/profile.dart';
import 'package:plannusapk/services/auth.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomeState createState() => _HomeState(new User());
}
class _HomeState extends State<Home> {
  User user;
  var tabs = [];

  _HomeState(User user) {
    this.user = user;
    this.user.init();
    this.tabs = [
      Scaffold(backgroundColor: Colors.deepOrangeAccent[100], body: DayScheduleWidget(ds: user.timetable.timetable['Mon'])), //home
      Scaffold(backgroundColor: Colors.yellow, body: TimeTableWidget(tt: user.timetable)),
      Messages(),
      Profile(),
    ];
  }

  int currentIndex = 0;

  final AuthService auth = AuthService();

  String header = 'Home';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
          },
        ),
        title: Text(header,
        style: TextStyle(
          color: Colors.white,
        )),
        backgroundColor: Colors.black54,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            tooltip: 'Add',
            onPressed: () async {
              List x = await Navigator.push(context, MaterialPageRoute(
                  builder: (context) => WeeklyEventAdder()
              ));
              setState(() {
                user.timetable.alter(x[4], x[0], x[1], x[2], x[3]);
                tabs[0] = Scaffold(backgroundColor: Colors.deepOrangeAccent[100], body: DayScheduleWidget(ds: user.timetable.timetable['Mon'])); //home
                tabs[1] = Scaffold(backgroundColor: Colors.yellow, body: TimeTableWidget(tt: user.timetable));
                print(user.timetable.timetable['Mon'].scheduler['0800-0900'].name);
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {

            },
          ),
          FlatButton.icon(
            icon: Icon(Icons.person,
            color: Colors.yellow,
            ),
            label: Text('logout',
              style: TextStyle(color: Colors.yellow)
            ),
              onPressed: () async {
                await auth.googleSignIn.isSignedIn().then((value) async {
                  if (value) {
                    AuthService.googleSignInAccount = null;
                    AuthService.googleUserId = null;
                    await auth.googleSignOut();
                  } else {
                    AuthService.currentUser = null;
                    await auth.signOut();
                  }
                });
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
            print(index); //remove
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
