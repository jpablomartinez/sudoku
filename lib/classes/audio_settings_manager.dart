import 'dart:math' as math;
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:sudoku/classes/interfaces/iaudio.dart';

class AudioSettingsManager implements IAudioSettingsManager {
  int _backroundVolume = 50;
  int _audioVolume = 50;
  AudioPlayer soundsPlayer = AudioPlayer();
  AudioPlayer backgroundMusic = AudioPlayer();

  AudioSettingsManager() {
    soundsPlayer.setVolume(_audioVolume.toDouble() / 100);
    backgroundMusic.setVolume(_backroundVolume.toDouble() / 100);
    playBackgroundLoopMusic();
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
    await soundsPlayer.play(AssetSource('audio/ui_woosh.wav'));
  }

  Future<void> playWriteNumber() async {
    int index = math.Random().nextInt(3) + 1;
    await soundsPlayer.play(AssetSource('audio/write$index.mp3'));
  }

  Future<void> playWinAudio() async {
    await backgroundMusic.stop();
    await soundsPlayer.play(AssetSource('audio/win.mp3'));
  }

  Future<void> playGameOverAudio() async {
    await backgroundMusic.stop();
    await soundsPlayer.play(AssetSource('audio/gameover.mp3'));
  }

  Future<void> playEraseAudio() async {
    await soundsPlayer.play(AssetSource('audio/erase.mp3'));
  }

  Future<void> playHintAudio() async {
    await soundsPlayer.play(AssetSource('audio/hint.wav'));
  }

  Future<void> playGameModeAudio() async {
    await soundsPlayer.play(AssetSource('audio/game-mode.mp3'));
  }

  Future<void> playBackgroundLoopMusic() async {
    backgroundMusic.onPlayerComplete.listen(handleLoopMusic);
  }

  void handleLoopMusic(void_) {
    playBackgroundMusic();
  }

  Future<void> playBackgroundMusic() async {
    int rand = Random().nextInt(2) + 1;
    String audio = 'audio/bg-sound-$rand.mp3';
    await backgroundMusic.play(AssetSource(audio));
  }

  Future<void> stopAudio() async {
    await backgroundMusic.stop();
    await soundsPlayer.stop();
  }
}
