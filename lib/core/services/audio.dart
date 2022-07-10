import 'dart:async';

import 'package:audioplayers/audioplayers.dart';

class Audio {
  final player = AudioPlayer();
  Future playAudio(String path) async {
    await player.play(AssetSource(path));
  }

  dispose() {
    player.pause();
    player.dispose();
    player.release();
  }
}
