import 'package:flutter/material.dart';
import 'package:plannusapk/messages/database.dart';
import 'package:plannusapk/services/auth.dart';
import 'package:plannusapk/shared/constants.dart';
import 'package:plannusapk/shared/loading.dart';

class Register extends StatefulWidget {

  // setting the property available for use
  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService auth = AuthService();
  final formKey = GlobalKey<FormState>(); // 'id' of form
  bool loading = false;
  // text field state
  String email = '';
  String password = '';
  String handle = '';
  String error = '';

  DatabaseMethods databaseMethods = new DatabaseMethods();

  @override
  Widget build(BuildContext context) {
    return loading ?  Loading() : Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        elevation: 0.0,
        title: Text('Sign up'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person, color: Colors.white),
            label: Text('Sign in',
              style: new TextStyle(color: Colors.white),
            ),
            onPressed: () {
              widget.toggleView();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Form(
            key: formKey, // keep track of form and its state
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
                TextFormField(
                  decoration: textInputDecorationEmail.copyWith(hintText: 'Handle (Start with @)'),
                  validator: (val) => val.isEmpty || val[0] != '@' ? 'Invalid Handle!' : null,
                  onChanged: (val) {
                    setState(() => handle = val);
                  },
                ),
                SizedBox(height: 20),
                RaisedButton(
                  color: Colors.amberAccent,
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(formKey.currentState.validate()) {
                      // checking whether content in form is valid
                      Map<String, String> userInfoMap = {
                        "email": email,
                        "handle" : handle
                      };
                      setState(() => loading = true);
                      dynamic result = await auth.registerWithEmailAndPassword(email, password, handle);
                      if (result == null) {
                        setState((){
                          error = 'Input valid email & password!';
                          loading = false;
                        });
                      }
                    }
                  },
                ),
                SizedBox(height: 12),
                Text(
                  error,
                  style: TextStyle(color: Colors.yellowAccent, fontSize: 14),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
