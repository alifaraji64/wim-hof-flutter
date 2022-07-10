import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  num value = 30;
  late SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    findBreaths();
  }

  findBreaths() async {
    prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('breaths')) return;
    setState(() {
      value = prefs.getInt('breaths')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            'select the number of breaths before retention',
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 10),
          Text(
            value.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          Slider(
            divisions: 14 * 5,
            label: value.toString(),
            inactiveColor: Colors.amber[100],
            activeColor: Colors.amber[600],
            thumbColor: Colors.amber,
            value: value.toDouble(),
            min: 10,
            max: 80,
            onChangeEnd: (selectedValue) {
              setState(() {
                value = selectedValue.toInt();
                prefs.setInt('breaths', selectedValue.toInt());
              });
            },
            onChanged: (selectedValue) {
              setState(() {
                value = selectedValue;
              });
            },
          )
        ]),
      )),
    );
  }
}
