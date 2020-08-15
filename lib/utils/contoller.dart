import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:modern_music/utils/playerstate.dart';

class Controller {
  static AudioPlayer audioPlayer = AudioPlayer();
  PlayerState playerState;
  PlayerState playerStates = PlayerState.stopped;
  Future stop() async {
    int result = await audioPlayer.stop();
    if (result == 1) playerState = PlayerState.stopped;
  }

  Future<int> play(SongInfo song) async {
    final result = await audioPlayer.play(song.filePath);
    if (result == 1) playerStates = PlayerState.playing;
    audioPlayer.setPlaybackRate(playbackRate: 1.0);
    return result;
  }
}
