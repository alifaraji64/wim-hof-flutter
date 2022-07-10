import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wim_hof/core/viewModels/BreathScreenViewModel.dart';
import 'package:wim_hof/meta/screens/ResultScreen.dart';

class BreathingScreen extends StatefulWidget {
  const BreathingScreen({Key? key}) : super(key: key);

  @override
  State<BreathingScreen> createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen>
    with TickerProviderStateMixin {
  late SharedPreferences prefs;
  int breaths = 30;
  @override
  void initState() {
    super.initState();
    findBreaths();
    BreathScreenViewModel viewModel =
        Provider.of<BreathScreenViewModel>(context, listen: false);
    viewModel.times.clear();
    (viewModel.breathTimer != null
        ? viewModel.breathTimer!.cancel()
        : debugPrint('breath timer is null'));
    (viewModel.retentionTimer != null
        ? viewModel.retentionTimer!.cancel()
        : debugPrint('breath timer is null'));
    (viewModel.fifteenTimer != null
        ? viewModel.fifteenTimer!.cancel()
        : debugPrint('breath timer is null'));
    viewModel.breathTimerStart();
  }

  findBreaths() async {
    prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('breaths')) return;
    setState(() {
      breaths = prefs.getInt('breaths')!;
    });
  }

  late BreathScreenViewModel viewModel;

  @override
  void didChangeDependencies() {
    viewModel = Provider.of<BreathScreenViewModel>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    viewModel.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<BreathScreenViewModel>(context, listen: false).reset();
        return true;
      },
      child: GestureDetector(
        onTap: () {
          Provider.of<BreathScreenViewModel>(context, listen: false)
              .fifteenRetentioStart();
        },
        child: Scaffold(
          body: SafeArea(
            child: AnimatedBackground(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'number of breaths: ' + breaths.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2.6,
                    ),
                    Center(
                        child: Text(
                            Provider.of<BreathScreenViewModel>(context,
                                    listen: true)
                                .counter
                                .toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 80,
                                fontWeight: FontWeight.bold))),
                    SizedBox(height: MediaQuery.of(context).size.height / 3),
                    !Provider.of<BreathScreenViewModel>(context, listen: false)
                            .breathIsDone
                        ? Center(
                            child: MaterialButton(
                            color: Colors.white,
                            child: const Text('end session'),
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      child: const ResultScreen(),
                                      type: PageTransitionType.bottomToTop));
                            },
                          ))
                        : const SizedBox()
                  ],
                ),
                vsync: this,
                behaviour: RandomParticleBehaviour(
                    options: const ParticleOptions(
                        baseColor: Colors.blue,
                        spawnMaxRadius: 30,
                        spawnMinRadius: 20,
                        spawnMaxSpeed: 100,
                        spawnMinSpeed: 50))),
          ),
        ),
      ),
    );
  }
}
