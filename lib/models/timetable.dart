import 'package:flutter/material.dart';
import 'package:plannusapk/models/schedule_time.dart';
import 'day_schedule.dart';
import 'weekly_event_adder.dart';

void main() => runApp(MaterialApp(
  home: TimeTableWidget(tt: new TimeTable()),
));

class TimeTable {
  static List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  Map<String, DaySchedule> timetable = {
    'Mon' : DaySchedule(),
    'Tue' : DaySchedule(),
    'Wed' : DaySchedule(),
    'Thu' : DaySchedule(),
    'Fri' : DaySchedule(),
    'Sat' : DaySchedule(),
    'Sun' : DaySchedule(),
  };

  Widget timeTableWidget() {
    return TimeTableWidget(tt: this);
  }
}

class TimeTableWidget extends StatefulWidget {
  final TimeTable tt;
  TimeTableWidget({this.tt});

  @override
  TimeTableWidgetState createState() => TimeTableWidgetState(tt: this.tt);
}

class TimeTableWidgetState extends State<TimeTableWidget> {
  TimeTable tt;
  TimeTableWidgetState({this.tt});

  int hex(int startTime) {
    switch (startTime) {
      case 800: return 0; break;
      case 900: return 1; break;
      case 1000: return 2; break;
      case 1100: return 3; break;
      case 1200: return 4; break;
      case 1300: return 5; break;
      case 1400: return 6; break;
      case 1500: return 7; break;
      case 1600: return 8; break;
      case 1700: return 9; break;
      case 1800: return 10; break;
      case 1900: return 11; break;
      default: return 0;
    }
  }

  void alter(String day, String bName, int bStart, int bEnd, bool isImportant) {
    int s = bStart;
    int e = bEnd;
    while (s < e) {
      ScheduleTiming t = ScheduleTiming(s);
      tt.timetable[day].scheduler[t.toString()].alter(bName);
      if (isImportant) { tt.timetable[day].scheduler[t.toString()].toggleImportant(); }
      else { tt.timetable[day].scheduler[t.toString()].toggleNotImportant(); }
      s += 100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
          },
        ),
        title: Text(
            "planNUS",
            textAlign: TextAlign.center
        ),
        actions: <Widget> [
          IconButton(
            icon: Icon(Icons.add),
            tooltip: 'Add Activity',
            onPressed: () async {
              List x = await Navigator.push(context, MaterialPageRoute(
                  builder: (context) => WeeklyEventAdder()
              ));
              setState(() {
                alter(x[4], x[0], x[1].time, x[2].time, x[3]);
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
            },
          )
        ],
      ),
      body: Column(
        children: <Widget> [
        Row(
          children: [
            SizedBox(width: 32.5),
            Row(
            children: TimeTable.days.map((day) => Row(
              children: <Widget> [
                SizedBox(width: 6.0),
                SizedBox(
                  width: 50.0,
                  child: Card(
                    color: Colors.amberAccent,
                    child: Text(
                      day,
                      textAlign: TextAlign.center,
                    ),
                  )
                ),
              ],
            )).toList()
          ),]
        ),
       Column(
         children: [
           Column(
             children: ScheduleTiming.allSlots.map((slot) => Container(
               color: Colors.white30,
                child: Column(
                  children: [
                    Row(
                     children: [
                       SizedBox(width: 2.5),
                       Card(
                         color: Colors.blue,
                         child: Column(
                           children: [
                             Text(ScheduleTime(time: slot.start).toString(), style: TextStyle(fontSize: 10.0)),
                             Text("-", style: TextStyle(fontSize: 12.0)),
                             Text(ScheduleTime(time: slot.end).toString(), style: TextStyle(fontSize: 10.0)),
                           ]
                         ),
                       ),
                       Row(
                         children: tt.timetable.values.map((ds) => Row(children: [ SizedBox(width: 6.0),
                             ds.scheduler[slot.toString()].weeklyActivityTemplate()])).toList()
                       ),
                      ],
                     ),
                    SizedBox(height: 12),
                    ]
                  ),
                )
               ).toList(),
              ),
              ]
             ),
          ],
    ));
  }
}
