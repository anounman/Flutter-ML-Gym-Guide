import 'package:Fit_Mode/workouts/arm_press.dart';
import 'package:Fit_Mode/workouts/sit_up.dart';
import 'package:Fit_Mode/workouts/squat.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class stal extends StatefulWidget {
  stal({Key? key}) : super(key: key);

  @override
  _stalState createState() => _stalState();
}

class _stalState extends State<stal> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Strength Alignment"
            .text
            .extraBold
            .black
            .xl2
            .make()
            .pOnly(top: 16, left: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => arm_press()),
                  );
                },
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image(
                    image: AssetImage('assets/arm_press.jpg'),
                    height: 150,
                    width: 150,
                  ),
                ).p12(),
              ),
              InkWell(
                focusColor: Colors.grey,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => squat()),
                  );
                },
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image(
                    image: AssetImage('assets/squat.jpg'),
                    height: 150,
                    width: 150,
                  ),
                ).p12(),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => situp()),
                  );
                },
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image(
                    image: AssetImage('assets/crunch.jpg'),
                    height: 150,
                    width: 150,
                  ),
                ).p12(),
              ),
            ],
          ),
        )
      ],
    );
  }
}
