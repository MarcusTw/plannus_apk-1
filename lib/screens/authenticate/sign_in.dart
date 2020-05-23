import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plannusapk/messages/database.dart';
import 'package:plannusapk/messages/helperfunctions.dart';
import 'package:plannusapk/services/auth.dart';
import 'package:plannusapk/shared/constants.dart';
import 'package:plannusapk/shared/loading.dart';
import 'package:shimmer/shimmer.dart';

class SignIn extends StatefulWidget {

  // setting the property available for use
  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService auth  = AuthService();
  final formKey = GlobalKey<FormState>(); // 'id' of form
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person, color: Colors.white),
            label: Text('Register',
            style: new TextStyle(color: Colors.white),
            ),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.deepPurpleAccent, Colors.amber[200], Colors.deepPurple],
            ),
          ),
          child: Form(
            key: formKey,
            child : Column (
              children: <Widget>[
                Image.asset('assets/planNUS.png', height: 250, width: 300),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(right: 30),
                  child: TextFormField(
                    decoration: textInputDecorationProfile.copyWith(hintText: 'Email'),
                    validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(right: 30),
                  child: TextFormField(
                    decoration: textInputDecorationPassword.copyWith(hintText: 'Password'),
                    obscureText: true,
                    validator: (val) => val.length < 6 ? 'Enter a longer password!' : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                ),
                SizedBox(height: 20),
                RaisedButton(
                  color: Colors.amberAccent,
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 51),
                  child: Shimmer.fromColors(
                    baseColor: Colors.white,
                    highlightColor: Colors.black,
                    child: Text(
                      'Sign in',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onPressed: () async {
                    if(formKey.currentState.validate()) {
                      QuerySnapshot userInfoSnapshot;
                      if(formKey.currentState.validate()) {
                      HelperFunctions.saveUserEmailSharedPreferences(email);
                      DatabaseMethods().getUserByUserEmail(email).then((value) {
                      userInfoSnapshot = value;
                      HelperFunctions
                          .saveUsernameSharedPreferences(userInfoSnapshot.documents[0].data["name"]);
                      print(userInfoSnapshot.documents[0].data["name"]);
                      HelperFunctions
                          .saveUserHandleSharedPreferences(userInfoSnapshot.documents[0].data["handle"]);
                      });
                      setState(() => loading = true);
                      dynamic result = await auth.signInWithEmailAndPassword(email, password);
                      if (result == null ) {
                        setState(() {
                          error = 'FAILED TO SIGN IN!';
                          loading = false;
                        });
                      } else {
                        HelperFunctions.saveUserLoggedInSharedPreferences(true);
                      }
                      }
                    }
                  },
                ),
                SizedBox(height: 5),
                RaisedButton(
                  color: Colors.pinkAccent,
                  child: Shimmer.fromColors(
                    baseColor: Colors.white,
                    highlightColor: Colors.black,
                    child: Text("Login with Google",
                        style : TextStyle(color: Colors.white
                        ),
                    ),
                  ),
                    hoverElevation: 1.0,
                    hoverColor: Colors.greenAccent,
                    onPressed: () async {
                      //setState(() => loading = true);
                      setState(() => loading = true);
                      print("here");
                      dynamic result = await auth.login();
                      if (result == null || result == false) {
                        setState(() {
                          error = 'FAILED TO SIGN IN!';
                          loading = false;
                        });
                      } else {
                        auth.createProfileForGoogleAccounts();
                      }
                    },
                ),
                SizedBox(height: 12),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
