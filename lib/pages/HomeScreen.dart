import 'package:Fit_Mode/pages/home.dart';
import 'package:Fit_Mode/pages/calorie.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  void _onTapitem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void createKey() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('arm_press', 0);
    prefs.setInt('situp', 0);
    prefs.setInt('squat', 0);
  }

  @override
  void initState() {
    super.initState();
  }

  static List<Widget> _widgetOptions = <Widget>[home(), Calorie()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: _widgetOptions.elementAt(_selectedIndex)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTapitem,
        selectedIconTheme: IconThemeData(color: Colors.blue, size: 40),
        selectedItemColor: Colors.blue,
        backgroundColor: Vx.blue50,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              LineAwesomeIcons.home,
            ),
            // ignore: deprecated_member_use
            title: "Home".text.make(),
          ),
          BottomNavigationBarItem(
            icon: Icon(LineAwesomeIcons.fire),
            // ignore: deprecated_member_use
            title: Text('calorie burn'),
          ),
        ],
      ),
    );
  }
}
