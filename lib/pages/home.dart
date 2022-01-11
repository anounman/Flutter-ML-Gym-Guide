import 'package:Fit_Mode/model/strength_alignment.dart';
import 'package:Fit_Mode/model/yoga_align.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class home extends StatefulWidget {
  home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Vx.blue50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "FIT MODE".text.bold.blue500.xl6.make().pOnly(top: 16, left: 16),
            "Workout every day".text.black.xl2.make().px16(),
            Image.asset(
              'assets/yoga.jpg',
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search Position to align',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ).pOnly(left: 16, right: 16),
            stal(),
            ygal()
          ],
        ),
      ),
    );
  }
}
