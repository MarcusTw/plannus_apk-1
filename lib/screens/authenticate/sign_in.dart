import 'package:flutter/material.dart';
import 'package:plannusapk/services/auth.dart';
import 'package:plannusapk/shared/constants.dart';
import 'package:plannusapk/shared/loading.dart';

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
        backgroundColor: Colors.black54,
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
          child: Form(
            key: formKey,
            child : Column (
              children: <Widget>[
                Image.asset('assets/planNUS.png', height: 250, width: 250),
                SizedBox(height: 20),
                TextFormField(
                  decoration: textInputDecorationProfile.copyWith(hintText: 'Email'),
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: textInputDecorationPassword.copyWith(hintText: 'Password'),
                  obscureText: true,
                  validator: (val) => val.length < 6 ? 'Enter a longer password!' : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20),
                RaisedButton(
                  color: Colors.amberAccent,
                  child: Text(
                    'Sign in',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(formKey.currentState.validate()) {
                      setState(() => loading = true);
                      dynamic result = await auth.signInWithEmailAndPassword(email, password);
                      if (result == null ) {
                        setState(() {
                          error = 'FAILED TO SIGN IN!';
                          loading = false;
                        });
                      }
                    }
                  },
                ),
                SizedBox(height: 5),
                RaisedButton(
                  color: Colors.pinkAccent,
                  child: Text("Login with Google",
                      style : TextStyle(color: Colors.white
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
