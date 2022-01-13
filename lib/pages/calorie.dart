import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:velocity_x/velocity_x.dart';

class Calorie extends StatefulWidget {
  Calorie({Key? key}) : super(key: key);

  @override
  _CalorieState createState() => _CalorieState();
}

class _CalorieState extends State<Calorie> {
  var arm_calories = 0;
  var squat_calories = 0;
  var situp_calories = 0;
  var total_calories = 0;
  bool isRest = false;
  late List<GDPData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  void getCalories() async {
    print("Get Calories");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      arm_calories = prefs.getInt('arm_press') ?? 0;
      squat_calories = prefs.getInt('squat') ?? 0;
      situp_calories = prefs.getInt('situp') ?? 0;
      total_calories = arm_calories + squat_calories + situp_calories;
      _chartData = getCahrtData();
      if (total_calories != 0) {
        isRest = false;
      } else {
        isRest = true;
      }
    });
  }

  List<GDPData> getCahrtData() {
    final List<GDPData> chartData = [
      if (arm_calories != 0) GDPData('arm_press', arm_calories),
      if (squat_calories != 0) GDPData('squat', squat_calories),
      if (situp_calories != 0) GDPData('situp', situp_calories),
    ];
    return chartData;
  }

  void reset() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('arm_press', 0);
    prefs.setInt('situp', 0);
    prefs.setInt('squat', 0);
    setState(() {
      isRest = true;
      getCalories();
    });
  }

  @override
  void initState() {
    getCalories();
    _chartData = getCahrtData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(children: [
        "Your Report"
            .text
            .headline2(context)
            .size(30)
            .blue300
            .makeCentered()
            .pOnly(top: 10),
        SfCircularChart(
          legend: Legend(
              isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
          tooltipBehavior: _tooltipBehavior,
          series: <CircularSeries>[
            DoughnutSeries<GDPData, String>(
              dataSource: _chartData,
              xValueMapper: (GDPData data, _) => data.work,
              yValueMapper: (GDPData data, _) => data.calories,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              enableTooltip: true,
            )
          ],
        ),
        Center(
          child: Text(
            'Total Calories Burn: ${total_calories} cal',
            style: TextStyle(fontSize: 25),
          ),
        ),
        if (arm_calories != 0)
          'Total Arm Press: ${arm_calories ~/ 0.02}'
              .text
              .xl3
              .make()
              .pOnly(top: 20),
        if (squat_calories != 0)
          'Total Squat: ${squat_calories ~/ 0.3}'
              .text
              .xl3
              .make()
              .pOnly(top: 10),
        if (situp_calories != 0)
          'Total Situp: ${situp_calories ~/ 0.32}'
              .text
              .xl3
              .make()
              .pOnly(top: 10),
        InkWell(
          onTap: () => reset(),
          child: isRest
              ? Container()
              : AnimatedContainer(
                      duration: Duration(seconds: 1),
                      height: isRest ? 0 : 50,
                      width:
                          isRest ? 0 : MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: isRest ? Colors.red : Vx.blue400),
                      child: Center(
                          child: isRest
                              ? ''.text.make()
                              : "Reset Count".text.white.make()))
                  .pOnly(top: 30),
        ),
      ]),
    );
  }
}

class GDPData {
  GDPData(this.work, this.calories);
  final String work;
  final int calories;
}
