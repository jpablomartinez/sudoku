import 'package:flutter/material.dart';
import 'package:sudoku/classes/settings_manager.dart';
import 'package:sudoku/colors.dart';
import 'package:sudoku/widgets/arrow_back.dart';
import 'package:sudoku/widgets/responsive_screen.dart';
import 'package:sudoku/widgets/setting.dart';
import 'package:sudoku/widgets/title_screen.dart';
import 'package:sudoku/widgets/version.dart';

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
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg-blue.png'),
            opacity: 0.5,
            fit: BoxFit.contain,
          ),
        ),
        child: ResponsiveScreen(
          bottom: true,
          squarishMainArea: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ArrowBack(onTap: () => Navigator.pop(context)),
                  const TitleScreen(title: 'Ajustes'),
                  const SizedBox(),
                ],
              ),
              const SizedBox(height: 15),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  children: [
                    Setting(
                      icon: 'assets/icons/volume.png',
                      title: 'Sonido',
                      label: 'Ajusta el volumen para cada acción del juego.',
                      actualValue: '${widget.settingsManager.getAudioSettingsManager().getAudioVolume()}',
                      slider: SizedBox(
                        height: 25,
                        width: size.width * 0.85 * 0.40,
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
                      icon: 'assets/icons/musical-note.png',
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
                      icon: 'assets/icons/visual-guide3.png',
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
                      icon: 'assets/icons/vibrate.png',
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
                  ],
                ),
              ),
            ],
          ),
          rectangularMenuArea: VersionApp(
            size: Size(size.width * 0.77, size.height * 0.07),
          ),
        ),
      ),
    );
  }
}
