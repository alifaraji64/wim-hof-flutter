import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllResultsScreen extends StatefulWidget {
  const AllResultsScreen({Key? key}) : super(key: key);

  @override
  State<AllResultsScreen> createState() => _AllResultsScreenState();
}

class _AllResultsScreenState extends State<AllResultsScreen> {
  SharedPreferences? prefs;
  @override
  void initState() {
    super.initState();
    SPInitilize();
  }

  void SPInitilize() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BarChart(BarChartData(
            gridData: FlGridData(show: false),
            maxY: 200,
            borderData: FlBorderData(
                border: const Border(
              top: BorderSide.none,
              right: BorderSide.none,
              left: BorderSide.none,
              bottom: BorderSide(width: 1),
            )),
            barGroups: prefs != null
                ? prefs!
                    .getStringList('times')!
                    .map(
                      (e) => BarChartGroupData(x: int.parse(e), barRods: [
                        BarChartRodData(
                            toY: double.parse(e),
                            width: 3,
                            color: Colors.amber,
                            fromY: 0),
                      ]),
                    )
                    .toList()
                : [
                    BarChartGroupData(x: 1),
                  ])),
      ),
    );
  }
}
