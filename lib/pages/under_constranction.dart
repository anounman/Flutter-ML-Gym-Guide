import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ConsTraction extends StatefulWidget {
  const ConsTraction({Key? key}) : super(key: key);

  @override
  _ConsTractionState createState() => _ConsTractionState();
}

class _ConsTractionState extends State<ConsTraction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Image.asset(
              'assets/under_cons.jpg',
              fit: BoxFit.scaleDown,
            ),
          ).p16(),
        ),
      ),
    );
  }
}
