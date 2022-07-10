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
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          PageTransition(
              child: const HomeScreen(), type: PageTransitionType.bottomToTop));
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
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Image.asset(
                'assets/splash.png',
                width: 250,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                  'Build Unbeatable Stamina and Edurance to Imporve Athletic Performance with Wim Hof Breating',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
