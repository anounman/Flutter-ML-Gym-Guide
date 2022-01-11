import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
    });
    print("Calories:${prefs.getInt('arm_press')}");
  }

  List<GDPData> getCahrtData() {
    final List<GDPData> chartData = [
      if (arm_calories != 0) GDPData('arm_press', arm_calories),
      if (squat_calories != 0) GDPData('squat', squat_calories),
      if (situp_calories != 0) GDPData('situp', situp_calories),
    ];
    return chartData;
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
    return Column(children: <Widget>[
      SfCircularChart(
        legend:
            Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
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
          'Total Calories Burn: ${total_calories} kcl',
          style: TextStyle(fontSize: 25),
        ),
      ),
    ]);
  }
}

class GDPData {
  GDPData(this.work, this.calories);
  final String work;
  final int calories;
}
