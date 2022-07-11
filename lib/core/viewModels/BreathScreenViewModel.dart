import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wim_hof/core/services/audio.dart';

class BreathScreenViewModel extends ChangeNotifier {
  final Audio _audio = Audio();
  int counter = 0;
  bool breathIsDone = false;
  Timer? retentionTimer;
  Timer? fifteenTimer;
  Timer? breathTimer;
  bool _fifteenIsStarted = false;
  static const numberOfBreaths = 30;
  List<int> times = [];
  playAudio(String path) async {
    await _audio.playAudio(path);
  }

  retentionTimeStart() async {
    await _audio.playAudio('retention.mp3');
    Timer.periodic(const Duration(seconds: 1), (timer) {
      counter++;
      retentionTimer = timer;
      notifyListeners();
    });
  }

  fifteenRetentioStart() async {
    if (!breathIsDone || _fifteenIsStarted) return;
    await playAudio('hold.mp3');
    _fifteenIsStarted = true;
    //cancel the retention timer
    retentionTimer!.cancel();
    handleSaveTime(counter);
    counter = 0;
    notifyListeners();
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      fifteenTimer = timer;
      if (counter == 15) {
        await playAudio('letgo.mp3');
        timer.cancel();
        _fifteenIsStarted = false;
        counter = 0;
        notifyListeners();
        Future.delayed(const Duration(seconds: 3), () {
          breathTimerStart();
        });
        return;
      }
      counter++;
      notifyListeners();
    });
  }

  breathTimerStart() async {
    counter = 0;
    breathIsDone = false;
    await playAudio('ready.mp3');
    final prefs = await SharedPreferences.getInstance();
    int breaths = prefs.containsKey('breaths')
        ? prefs.getInt('breaths')!
        : numberOfBreaths;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      breathTimer = timer;
      if (counter == breaths) {
        timer.cancel();
        counter = 0;
        notifyListeners();
        retentionTimeStart();
        breathIsDone = true;
        return;
      }
      counter++;
      notifyListeners();
    });
  }

  handleSaveTime(int counter) async {
    //final prefs = await SharedPreferences.getInstance();
    times.add(counter);
    //print(times);
    //print('saveing data');
  }

  void reset() {
    disposePlayer();
    retentionTimer != null ? breathTimer!.cancel() : null;
    retentionTimer != null ? retentionTimer!.cancel() : null;
    fifteenTimer != null ? fifteenTimer!.cancel() : null;
    _fifteenIsStarted = false;
    breathIsDone = false;
    //times.clear();
  }

  String convertToMin(int seconds) {
    return Duration(seconds: seconds).inMinutes.toString() +
        ':' +
        //add one zero to the soconds to make the seconds 2 digits for appearence purposes
        (seconds.remainder(60).toString().length == 1
            ? seconds.remainder(60).toString() + '0'
            : seconds.remainder(60).toString());
  }

  void saveToSP() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('times')) {
      print('we have times save din db');
      List<String> newList = [
        ...prefs.getStringList('times')!,
        ...[...times.map((e) => e.toString())]
      ];
      prefs.setStringList('times', newList);
      //print(newList);
      return;
    }
    prefs.setStringList('times', [...times.map((e) => e.toString())]);
  }

  disposePlayer() {
    _audio.dispose();
  }
}
