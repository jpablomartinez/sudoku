abstract class IAudioSettingsManager {
  ///Get volume for background music
  int getBackgroundVolume();

  ///Get volume for audios like set level, write number, etc
  int getAudioVolume();

  ///Set background music volume
  void setBackgroundVolume(int v);

  ///Set audio music volume
  void setAudioVolume(int v);
}
