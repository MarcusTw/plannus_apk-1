import 'package:flutter/material.dart';
import 'schedule_time.dart';

class WeeklyEventAdder extends StatefulWidget {
  @override
  _WeeklyEventAdderState createState() => _WeeklyEventAdderState();
}

class _WeeklyEventAdderState extends State<WeeklyEventAdder> {

  static List<DropdownMenuItem<ScheduleTime>> buildDropDownMenuItems(List<ScheduleTime> times) {
    List<DropdownMenuItem<ScheduleTime>> items = List();
    for (ScheduleTime t in times) {
      items.add(
        DropdownMenuItem(
          value: t,
          child: Text(t.toString()),
        ),
      );
    }
    return items;
  }
  static List<DropdownMenuItem<String>> buildDropDownMenuItems2(List<String> days) {
    List<DropdownMenuItem<String>> items = List();
    for (String t in days) {
      items.add(
        DropdownMenuItem(
          value: t,
          child: Text(t.toString()),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<String>> _dropdownDays = buildDropDownMenuItems2(['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']);
  List<DropdownMenuItem<ScheduleTime>> _dropdownStartTimes = buildDropDownMenuItems(ScheduleTime.startTimeList);
  List<DropdownMenuItem<ScheduleTime>> _dropdownEndTimes= buildDropDownMenuItems(ScheduleTime.endTimeList);
  String _selectedName;
  ScheduleTime _selectedStartTime;
  ScheduleTime _selectedEndTime;
  String _selectedDay;
  bool _selectedImportance;
  String error = '';
  String addable = '';
  void init() {
    _selectedName = null;
    _selectedStartTime = null;
    _selectedEndTime = null;
    _selectedImportance = null;
    _selectedDay = null;
    error = '';
    addable = '';
  }

  onChangeStartTime(ScheduleTime selectedStartTime) {
    setState(() {
      _selectedStartTime = selectedStartTime;
    });
  }
  onChangeEndTime(ScheduleTime selectedEndTime) {
    if (selectedEndTime.time <= _selectedStartTime.time) {
      setState((){
        error = "Inappropriate End Time!";
      });
    } else {
      setState(() {
        error = '';
        _selectedEndTime = selectedEndTime;
      });
    }
  }
  onChangeImportance(bool choice) {
    setState(() {
      _selectedImportance = choice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(30, 8, 30, 8),
              child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'What activity is it',
                    filled: true,
                    fillColor: Colors.grey,
                    contentPadding: const EdgeInsets.all(0.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  textAlign: TextAlign.center,
                  onChanged: (String input) {
                    setState(() {
                      _selectedName = input;
                    });
                  }
              ),
            ),
            Text('Which day?'),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.fromLTRB(30, 8, 30, 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[300],
              ),
              child: DropdownButton(
                focusColor: Colors.red,
                autofocus: true,
                value: _selectedDay,
                items: _dropdownDays,
                onChanged: (selectedDay) => setState(() {
                  _selectedDay = selectedDay;
                }),
              ),
            ),

            Text("Start"),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.fromLTRB(30, 8, 30, 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[300],
              ),
              child: DropdownButton(
                value: _selectedStartTime,
                items: _dropdownStartTimes,
                onChanged: onChangeStartTime,
              ),
            ),
            Text("End"),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.fromLTRB(30, 8, 30, 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[300],
              ),
              child: DropdownButton(
                value: _selectedEndTime,
                items: _dropdownEndTimes,
                onChanged: onChangeEndTime,
              ),
            ),
            Text(
              error,
              style: TextStyle(color: Colors.red, fontSize: 14),
            ),
            Text("Is it important?"),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.fromLTRB(30, 8, 30, 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[300],
              ),
              child: DropdownButton(
                value: _selectedImportance,
                items: <DropdownMenuItem<bool>>[
                  DropdownMenuItem(
                      value: true,
                      child: Text("Yes")
                  ),
                  DropdownMenuItem(
                      value: false,
                      child: Text("No")
                  )
                ],
                onChanged: onChangeImportance,
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    child: Text("Add"),
                    onPressed: () {
                      if (_selectedImportance == null || _selectedEndTime == null ||
                          _selectedStartTime == null || _selectedName == null || _selectedDay == null) {
                        setState(() {
                          addable = 'Please fill in all fields!';
                        });
                      } else {
                        Navigator.pop(context, [
                          _selectedName,
                          _selectedStartTime,
                          _selectedEndTime,
                          _selectedImportance,
                          _selectedDay
                        ]);
                        init();
                      }
                    },
                  ),
                  SizedBox(width: 20.0),
                  RaisedButton(
                      child: Text("Cancel"),
                      onPressed: () {
                        Navigator.pop(context);
                      }
                  ),
                ]
            ),
            SizedBox(height: 10),
            Text(
              addable,
              style: TextStyle(
                color: Colors.red,
              )
            )
          ],
        ),
      ),
    );
  }
}
