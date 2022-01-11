import 'package:Fit_Mode/pages/under_constranction.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ygal extends StatefulWidget {
  const ygal({Key? key}) : super(key: key);

  @override
  _ygalState createState() => _ygalState();
}

class _ygalState extends State<ygal> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Yoga Alignment"
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
                    MaterialPageRoute(builder: (context) => ConsTraction()),
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
                    image: AssetImage('assets/yoga1.jpg'),
                    height: 150,
                    width: 150,
                  ),
                ).p12(),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ConsTraction()),
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
                    image: AssetImage('assets/yoga2.jpg'),
                    height: 150,
                    width: 150,
                  ),
                ).p12(),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ConsTraction()),
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
                    image: AssetImage('assets/yoga3.jpg'),
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
