import 'package:sudoku/classes/audio_settings_manager.dart';
import 'package:sudoku/classes/game_theme.dart';
import 'package:sudoku/utils/color_theme.dart';

abstract class ISettingsManager {
  bool getVisualGuide();
  bool getCanVibrate();
  bool getSaveOnExit();
  GameTheme getGameTheme();
  AudioSettingsManager getAudioSettingsManager();

  void setVisualGuide(bool v);
  void setCanVibrate(bool v);
  void setSaveOnExit(bool v);
  void setGameTheme(ColorTheme colorTheme);
  void setAudioSettingsManager(AudioSettingsManager audioSettingsManager);
}
