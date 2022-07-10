import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wim_hof/meta/screens/AllResultsScreen.dart';
import 'package:wim_hof/meta/screens/BreathingScreen.dart';
import 'package:wim_hof/meta/screens/SettingScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MaterialButton(
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                    child: const BreathingScreen(),
                    type: PageTransitionType.bottomToTop,
                  ));
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.start),
                Text(
                  ' Start',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            color: Colors.white,
          ),
          MaterialButton(
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                    child: const SettingScreen(),
                    type: PageTransitionType.bottomToTop,
                  ));
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.settings),
                Text(
                  ' Settings',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            color: Colors.white,
          ),
          MaterialButton(
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: const AllResultsScreen(),
                      type: PageTransitionType.bottomToTop));
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.find_replace),
                Text(
                  ' Results',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            color: Colors.white,
          ),
        ],
      ),
    ));
  }
}
