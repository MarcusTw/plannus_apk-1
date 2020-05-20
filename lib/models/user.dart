import 'day_schedule.dart';

class User {

  final String uid;
  User({  this.uid  });
  DayScheduleWidget timetable;
  int phoneNumber = 93268245;
  bool schedule = false;
  void init() {
    timetable = new DayScheduleWidget();
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