import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/animation.dart';

class Audio {
  Future playAudio(String path) async {
    final player = AudioPlayer();
    await player.play(AssetSource(path));
  }
}
