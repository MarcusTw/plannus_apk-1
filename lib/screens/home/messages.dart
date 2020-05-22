import 'package:flutter/material.dart';
import 'package:plannusapk/messages/chats.dart';

class Messages extends StatefulWidget {

  @override
  _MessagesState createState() => _MessagesState();
}



class _MessagesState extends State<Messages> {


  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = new TextEditingController();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home : Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30),
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                ),
              )
            ),
            Padding(
              padding : const EdgeInsets.only(left: 2.5, right: 2.5),
              child: Divider(),
            )
          ],
        )
      ),
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.deepPurpleAccent,
            elevation: 4,
            hoverColor: Colors.green,
            splashColor: Colors.green,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                    Chats(),
                )
              );
            },
            label: new Icon(Icons.message, color: Colors.white)),
      ),
    );
  }
}
