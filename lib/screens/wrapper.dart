import 'package:flutter/material.dart';
import 'package:plannusapk/models/user.dart';
import 'package:plannusapk/screens/authenticate/authenticate.dart';
import 'package:plannusapk/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);

    // return either Home or Authenticate widget
    return user == null ? Authenticate() : Home();
  }
}
