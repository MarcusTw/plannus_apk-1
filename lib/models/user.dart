import 'timetable.dart';

class User {
  final String uid;
  TimeTable timetable;
  int phoneNumber;
  bool schedule = false;
  bool initial = true;

  User({this.uid});

  void init() {
    if (initial) {
      timetable = new TimeTable();
      initial = false;
    }
  }
}

class UserData {
   String uid;
   String name;
   String handle;
  UserData.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    handle = data['handle'];
  }
}
