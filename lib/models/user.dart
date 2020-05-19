import 'day_schedule.dart';

class User {
  final String uid;
  DayScheduleWidget timetable;
  int phoneNumber = 93268245;
  bool schedule = false;
  User({  this.uid  });

  void init() {
    timetable = new DayScheduleWidget();
  }
}