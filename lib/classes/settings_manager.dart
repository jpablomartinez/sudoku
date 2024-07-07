import 'package:sudoku/classes/audio_settings_manager.dart';
import 'package:sudoku/classes/game_theme.dart';
import 'package:sudoku/classes/interfaces/isetting.dart';
import 'package:sudoku/utils/color_theme.dart';

class SettingsManager implements ISettingsManager {
  bool _canVibrate = true;
  GameTheme _gameTheme = GameTheme.blue();
  bool _saveOnExit = false;
  bool _visualGuide = true;
  late AudioSettingsManager _audioSettingsManager;

  @override
  AudioSettingsManager getAudioSettingsManager() {
    return _audioSettingsManager;
  }

  @override
  bool getCanVibrate() {
    return _canVibrate;
  }

  @override
  GameTheme getGameTheme() {
    return _gameTheme;
  }

  @override
  bool getSaveOnExit() {
    return _saveOnExit;
  }

  @override
  bool getVisualGuide() {
    return _visualGuide;
  }

  @override
  void setCanVibrate(bool v) {
    _canVibrate = v;
  }

  @override
  void setGameTheme(ColorTheme colorTheme) {
    if (colorTheme == ColorTheme.blue) {
      _gameTheme = GameTheme.blue();
    } else if (colorTheme == ColorTheme.green) {
      _gameTheme = GameTheme.green();
    } else if (colorTheme == ColorTheme.purple) {
      _gameTheme = GameTheme.purple();
    }
  }

  @override
  void setSaveOnExit(bool v) {
    _saveOnExit = v;
  }

  @override
  void setVisualGuide(bool v) {
    _visualGuide = v;
  }

  @override
  void setAudioSettingsManager(AudioSettingsManager audioSettingsManager) {
    _audioSettingsManager = audioSettingsManager;
  }
}
