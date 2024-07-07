import 'package:audioplayers/audioplayers.dart';

class AudioController {
  //use one audioplayer for sounds
  //use one audioplayer for background loop

  late AudioPlayer soundsPlayer;
  late AudioPlayer backgroundMusic;

  AudioController() {
    soundsPlayer = AudioPlayer();
    backgroundMusic = AudioPlayer();
  }

  void setVolumeSoundPlayer(int v) {
    soundsPlayer.setVolume(v.toDouble());
  }

  void setVolumeBackgroundPlayer(int v) {
    backgroundMusic.setVolume(v.toDouble());
  }

  Future<void> playSelectAudio() async {
    await soundsPlayer.play(AssetSource('audio/write_number.wav'));
  }

  Future<void> playWinAudio() async {
    //await soundsPlayer.play(AssetSource('audio/select.wav'));
  }

  void playBackgroundLoopAudio() {}

  void playWriteNumberAudio() {}

  void playMainBackgroundAudio() {}

  Future<void> playEraseAudio() async {
    await soundsPlayer.play(AssetSource('audio/erase.wav'));
  }

  Future<void> playHintAudio() async {
    await soundsPlayer.play(AssetSource('audio/hint.wav'));
  }

  Future<void> playGameModeBackgroundAudio() async {
    //await backgroundMusic.play(AssetSource('audio/game_mode.wav'));
  }
}
