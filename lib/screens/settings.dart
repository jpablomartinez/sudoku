import 'package:flutter/material.dart';
import 'package:sudoku/classes/settings_manager.dart';
import 'package:sudoku/colors.dart';
import 'package:sudoku/widgets/layout.dart';
import 'package:sudoku/widgets/setting.dart';

class SettingsManagerView extends StatefulWidget {
  final SettingsManager settingsManager;

  const SettingsManagerView({super.key, required this.settingsManager});

  @override
  State<SettingsManagerView> createState() => _SettingsManagerState();
}

class _SettingsManagerState extends State<SettingsManagerView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Layout(
      imgPath: widget.settingsManager.getGameTheme().backgroundImage,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(
                height: size.height * 0.05,
              ),
              Container(
                width: size.width,
                height: 60,
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: SudokuColors.onahu,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: SudokuColors.onahu.withOpacity(0.8),
                          offset: const Offset(0, 4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/icons/arrow2.png',
                        height: 17,
                        color: const Color(0xff3B95FF),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ClipRRect(
                child: Container(
                  width: size.width * 0.61,
                  height: 45,
                  decoration: BoxDecoration(
                    color: SudokuColors.onahu,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xff9FC6F3),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: SudokuColors.onahu.withOpacity(0.8),
                        offset: const Offset(0, 4),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'Ajustes',
                      style: TextStyle(
                        color: SudokuColors.dodgerBlueDarker,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Setting(
                icon: 'assets/icons/audio.png',
                title: 'Sonido',
                label: 'Ajusta el volumen para cada acción del juego.',
                actualValue: '${widget.settingsManager.getAudioSettingsManager().getAudioVolume()}',
                slider: SizedBox(
                  height: 25,
                  width: size.width * 0.85 * 0.4,
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 10, // Set the height of the track
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
                    ),
                    child: Slider(
                      inactiveColor: const Color(0xffD0D0E4),
                      activeColor: const Color(0xff4B9CFA),
                      value: widget.settingsManager.getAudioSettingsManager().getAudioVolume().toDouble(),
                      onChanged: (double value) {
                        setState(() {
                          widget.settingsManager.getAudioSettingsManager().setAudioVolume(value.toInt());
                        });
                      },
                      divisions: 10,
                      max: 100,
                    ),
                  ),
                ),
              ),
              Setting(
                icon: 'assets/icons/music.png',
                title: 'Música',
                label: 'Ajusta el volumen de la música de fondo cuando estás jugando.',
                actualValue: '${widget.settingsManager.getAudioSettingsManager().getBackgroundVolume()}',
                slider: SizedBox(
                  height: 25,
                  width: size.width * 0.85 * 0.4,
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 10, // Set the height of the track
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
                    ),
                    child: Slider(
                      inactiveColor: const Color(0xffD0D0E4),
                      activeColor: const Color(0xff4B9CFA),
                      value: widget.settingsManager.getAudioSettingsManager().getBackgroundVolume().toDouble(),
                      onChanged: (double value) {
                        setState(() {
                          widget.settingsManager.getAudioSettingsManager().setBackgroundVolume(value.toInt());
                        });
                      },
                      divisions: 10,
                      max: 100,
                    ),
                  ),
                ),
              ),
              Setting(
                icon: 'assets/icons/audio.png',
                title: 'Guía Visual',
                label: 'Señaliza la fila, columna y región correspondiente a la celda seleccionada',
                actualValue: widget.settingsManager.getVisualGuide() ? 'On' : 'Off',
                slider: SizedBox(
                  height: 25,
                  width: size.width * 0.85 * 0.21,
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 10, // Set the height of the track
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
                    ),
                    child: Slider(
                      inactiveColor: const Color(0xffD0D0E4),
                      activeColor: const Color(0xff4B9CFA),
                      value: widget.settingsManager.getVisualGuide() ? 2 : 1,
                      onChanged: (double value) {
                        setState(() {
                          widget.settingsManager.setVisualGuide(value == 2);
                        });
                      },
                      min: 1,
                      max: 2,
                    ),
                  ),
                ),
              ),
              Setting(
                icon: 'assets/icons/music.png',
                title: 'Vibrar',
                label: 'Tu dispositivo vibrará si cometes un error en el juego.',
                actualValue: widget.settingsManager.getCanVibrate() ? 'On' : 'Off',
                slider: SizedBox(
                  height: 25,
                  width: size.width * 0.85 * 0.21,
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 10, // Set the height of the track
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
                    ),
                    child: Slider(
                      inactiveColor: const Color(0xffD0D0E4),
                      activeColor: const Color(0xff4B9CFA),
                      value: widget.settingsManager.getCanVibrate() ? 2 : 1,
                      onChanged: (double value) {
                        setState(() {
                          widget.settingsManager.setCanVibrate(value == 2);
                        });
                      },
                      min: 1,
                      max: 2,
                    ),
                  ),
                ),
              ),
              Setting(
                icon: 'assets/icons/audio.png',
                title: 'Guardar',
                label: 'Cada cierto tiempo se va guardando tu progreso en la partida.',
                actualValue: widget.settingsManager.getSaveOnExit() ? 'On' : 'Off',
                slider: SizedBox(
                  height: 25,
                  width: size.width * 0.85 * 0.21,
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 10, // Set the height of the track
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
                    ),
                    child: Slider(
                      inactiveColor: const Color(0xffD0D0E4),
                      activeColor: const Color(0xff4B9CFA),
                      value: widget.settingsManager.getSaveOnExit() ? 2 : 1,
                      onChanged: (double value) {
                        setState(() {
                          widget.settingsManager.setSaveOnExit(value == 2);
                        });
                      },
                      min: 1,
                      max: 2,
                    ),
                  ),
                ),
              ),
              //TODO: SPACE FOR SETTINGS
            ],
          ),
          Container(
            width: size.width * 0.77,
            height: size.height * 0.07,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              alignment: Alignment.center,
              child: const Text(
                'JK STUDIOS - Version 0.4.1',
                style: TextStyle(
                  color: SudokuColors.congressBlue,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
