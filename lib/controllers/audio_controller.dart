import 'package:audioplayers/audioplayers.dart';

class AudioController {
  //use one audioplayer for sounds
  //use one audioplayer for background loop

  late AudioPlayer soundsPlayer;
  late AudioPlayer backgroundMusic;
  int soundVolume = 1;
  int backgroundMusicVolume = 1;

  AudioController() {
    soundsPlayer = AudioPlayer();
    backgroundMusic = AudioPlayer();
  }

  Future<void> playSelectAudio() async {
    await soundsPlayer.play(AssetSource('audio/select.wav'));
  }

  Future<void> playWinAudio() async {
    await soundsPlayer.play(AssetSource('audio/select.wav'));
  }

  void playBackgroundLoopAudio() {}

  void playWriteNumberAudio() {}

  void playMainBackgroundAudio() {}

  Future<void> playGameModeBackgroundAudio() async {
    await backgroundMusic.play(AssetSource('audio/game_mode.wav'));
  }
}
