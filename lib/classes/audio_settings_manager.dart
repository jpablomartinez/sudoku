import 'package:audioplayers/audioplayers.dart';
import 'package:sudoku/classes/interfaces/iaudio.dart';

class AudioSettingsManager implements IAudioSettingsManager {
  int _backroundVolume = 0;
  int _audioVolume = 0;
  AudioPlayer soundsPlayer = AudioPlayer();
  AudioPlayer backgroundMusic = AudioPlayer();

  AudioSettingsManager() {
    soundsPlayer.setVolume(_audioVolume.toDouble() / 100);
    backgroundMusic.setVolume(_backroundVolume.toDouble() / 100);
  }

  @override
  int getAudioVolume() {
    return _audioVolume;
  }

  @override
  int getBackgroundVolume() {
    return _backroundVolume;
  }

  @override
  void setAudioVolume(int v) {
    _audioVolume = v;
    soundsPlayer.setVolume(v.toDouble() / 100);
  }

  @override
  void setBackgroundVolume(int v) {
    _backroundVolume = v;
    backgroundMusic.setVolume(v.toDouble() / 100);
  }

  void setVolumeSoundPlayer(int v) {
    soundsPlayer.setVolume(v.toDouble() / 100);
  }

  void setVolumeBackgroundPlayer(int v) {
    backgroundMusic.setVolume(v.toDouble() / 100);
  }

  Future<void> playSelectAudio() async {
    await soundsPlayer.play(AssetSource('audio/write_number.wav'));
  }

  Future<void> playWinAudio() async {
    //await soundsPlayer.play(AssetSource('audio/select.wav'));
  }

  void playBackgroundLoopAudio() {}

  Future<void> playWriteNumberAudio() async {
    await soundsPlayer.play(AssetSource('audio/write_number.wav'));
  }

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
