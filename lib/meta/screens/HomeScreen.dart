import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wim_hof/meta/screens/BreathingScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                    child: BreathingScreen(),
                    type: PageTransitionType.bottomToTop,
                  ));
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [Icon(Icons.start), Text(' Start')],
            ),
            color: Colors.white,
          ),
          MaterialButton(
            onPressed: () {},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [Icon(Icons.settings), Text(' Settings')],
            ),
            color: Colors.white,
          ),
        ],
      ),
    ));
  }
}
