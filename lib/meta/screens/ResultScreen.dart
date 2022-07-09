import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wim_hof/core/viewModels/BreathScreenViewModel.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedBackground(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:
                    Provider.of<BreathScreenViewModel>(context, listen: false)
                        .times
                        .asMap()
                        .entries
                        .map((entry) => Container(
                              color: Colors.blue,
                              padding: EdgeInsets.all(10),
                              width: 200,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Round ' + (entry.key + 1).toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                  Text(
                                    entry.value < 60
                                        ? entry.value.toString()
                                        : Provider.of<BreathScreenViewModel>(
                                                context,
                                                listen: false)
                                            .convertToMin(entry.value),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
              ),
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
    );
  }
}
