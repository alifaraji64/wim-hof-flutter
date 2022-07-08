import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:wim_hof/core/services/audio.dart';

class BreathScreenViewModel extends ChangeNotifier {
  final Audio _audio = Audio();
  int counter = 0;
  bool breathIsDone = false;
  Timer? retentionTimer;
  Timer? fifteenTimer;
  Timer? breathTimer;
  bool _fifteenIsStarted = false;
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
    print(counter);
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
    Timer.periodic(const Duration(seconds: 3), (timer) {
      breathTimer = timer;
      if (counter == 5) {
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
}
