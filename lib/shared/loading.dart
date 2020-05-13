import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.amber[800],
          size: 50,
        ),
    ),
    );
  }
}


