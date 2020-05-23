import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plannusapk/messages/database.dart';
import 'package:plannusapk/models/user.dart';
import 'package:plannusapk/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final AuthService auth = AuthService();
  final formKey = GlobalKey<FormState>(); // 'id' of form
  bool loading = false;
  // text field state
  String name = '';
  String password = '';
  String handle = '';
  String error = '';
  String key = '';

  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot currentUser;


  profileName(String uid) async{
    await databaseMethods
        .getHandleByEmail(uid)
        .then((value) => {
      setState(() => handle = value['handle'])
    });
  }
  displayHandle() async {
    await auth.googleSignIn.isSignedIn() ? profileName(AuthService.googleUserId)
        : profileName(AuthService.currentUser.uid);
  }
  @override
  void initState() {
    // TODO: implement initState
    displayHandle();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);
    void foo() async {
      String str = await databaseMethods.getSpecificUserData(user.uid);
      setState(() {
        key = str;
      });
    }
    //print(key);
    //print(user.uid);
//    void foo() async{
//      final String hand = await databaseMethods.getSpecificUserData(user.uid);
//      asd = hand;
//    }
//    databaseMethods.getSpecificUserData(user.uid).then((value) => {
//      setState(() => {
//        handle = value
//      })
//    });
//    final userData = Provider.of<QuerySnapshot>(context);
//    for (var doc in userData.documents) {
//      print(doc.data);
//    }
    return new Scaffold(
      appBar: AppBar(
        title: Text("Welcome, " + handle,
            style: TextStyle(color: Colors.black)
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.deepPurpleAccent, Colors.white70, Colors.deepPurple],
            ),
          ),
          child: Form(
            key: formKey, // keep track of form and its state
            child : Column (
              children: <Widget>[
                Image.asset('assets/profilepicture.png', height: 300, width: 300),
                Container(
                  margin: EdgeInsets.only(right: 30),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Name',
                        icon: Icon(Icons.person_outline, color: Colors.blue),
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[300], width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        )
                    ),
                    validator: (val) => val.isEmpty ? 'Enter your name' : null,
                    onChanged: (val) {
                      setState(() => name = val);
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(right: 30),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Handle',
                        icon: Icon(Icons.alternate_email, color: Colors.blue),
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[300], width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        )
                    ),
                    obscureText: false,
                    validator: (val) => val[0] != '@' ? 'Handle starts with @!' : null,
                    onChanged: (val) {
                      setState(() => handle = val);
                      //print(handle);
                    },
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget> [
                    RaisedButton(
                      color: Colors.blueAccent,
                      child: Shimmer.fromColors(
                        highlightColor: Colors.black,
                        baseColor: Colors.white,
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      onPressed: () async {
                        //print(handle);
                        if(formKey.currentState.validate()) {
                          print(AuthService.googleUserId);
                          await auth.googleSignIn.isSignedIn() ?
                          await databaseMethods.updateSpecificUserData(AuthService.googleUserId, name, handle)
                              : await databaseMethods.updateSpecificUserData(
                              user.uid, name, handle);
                          setState(() {
                            error = 'Update successful!';
                            key = handle;
                          });
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  error,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}