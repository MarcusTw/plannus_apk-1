import 'package:flutter/material.dart';
import 'schedule_time.dart';

class DailyEventAdder extends StatefulWidget {
  @override
  _DailyEventAdderState createState() => _DailyEventAdderState();
}

class _DailyEventAdderState extends State<DailyEventAdder> {

  static List<DropdownMenuItem<ScheduleTime>> buildDropDownMenuItems(List times) {
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
  List<DropdownMenuItem<ScheduleTime>> _dropdownStartTimes = buildDropDownMenuItems(ScheduleTime.startTimeList);
  List<DropdownMenuItem<ScheduleTime>> _dropdownEndTimes= buildDropDownMenuItems(ScheduleTime.endTimeList);
  String _selectedName;
  ScheduleTime _selectedStartTime;
  ScheduleTime _selectedEndTime;
  bool _selectedImportance;
  String error = '';
  String addable = '';

  void init() {
    _selectedName = null;
    _selectedStartTime = null;
    _selectedEndTime = null;
    _selectedImportance = null;
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
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'What activity is it',
                    filled: true,
                    fillColor: Colors.grey,
                    contentPadding: const EdgeInsets.all(10.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0),
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
            Text("Start"),
            SizedBox(height: 20.0,),
            DropdownButton(
              value: _selectedStartTime,
              items: _dropdownStartTimes,
              onChanged: onChangeStartTime,
            ),
            Text("End"),
            SizedBox(height: 20.0),
            DropdownButton(
              value: _selectedEndTime,
              items: _dropdownEndTimes,
              onChanged: onChangeEndTime,
            ),
            SizedBox(height: 12),
            Text(
              error,
              style: TextStyle(color: Colors.red, fontSize: 14),
            ),
            Text("Is it important?"),
            SizedBox(height: 20.0),
            DropdownButton(
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
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    child: Text("Add"),
                    onPressed: () {
                      if (_selectedImportance == null || _selectedEndTime == null ||
                          _selectedStartTime == null || _selectedName == null ) {
                        setState(() {
                          addable = 'Please fill in all fields!';
                        });
                      } else {
                        Navigator.pop(context, [
                          _selectedName,
                          _selectedStartTime,
                          _selectedEndTime,
                          _selectedImportance
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
                  )]
            ),
            SizedBox(height: 12),
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
