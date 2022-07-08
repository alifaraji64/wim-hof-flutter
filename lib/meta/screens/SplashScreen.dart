import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wim_hof/meta/screens/HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          PageTransition(
              child: HomeScreen(), type: PageTransitionType.bottomToTop));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/splash.png',
                width: 250,
              ),
            ),
            SizedBox(height: 20),
            const Center(
              child: Text(
                  'build unbeatable stamina and edurance with wim hof breating method',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}
