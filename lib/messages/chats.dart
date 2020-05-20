import 'package:flutter/material.dart';
import 'package:plannusapk/screens/home/home.dart';
import 'package:plannusapk/screens/home/messages.dart';

class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  TextEditingController searchTextEditingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.deepPurple,
          appBar: AppBar(
            leading: IconButton(
              icon: new Icon(Icons.arrow_back_ios,
                color: Colors.white),
              onPressed:() {
                Navigator.pop(context);
              },
            ),
          ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.deepPurple,
                padding : EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: searchTextEditingController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'Search user',
                          hintStyle: TextStyle(color: Colors.black),
                          focusedBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25),
                            borderSide: new BorderSide(
                              color: Colors.white,
                              width: 2.5,
                            ),
                          ),
                          enabledBorder: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.white
                              )
                          ), fillColor: Colors.white
                        ),
                    )),
                    IconButton(
                      padding: EdgeInsets.fromLTRB(20,2,2,2),
                      icon: new Icon(Icons.search, color: Colors.blue),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        ),
    );
  }
}
