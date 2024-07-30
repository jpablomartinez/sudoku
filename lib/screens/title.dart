import 'package:flutter/material.dart';
import 'package:sudoku/classes/audio_settings_manager.dart';
import 'package:sudoku/classes/settings_manager.dart';
import 'package:sudoku/colors.dart';
import 'package:sudoku/screens/game_modes.dart';
import 'package:sudoku/screens/records.dart';
import 'package:sudoku/screens/settings.dart';
import 'package:sudoku/widgets/fade_transition.dart';
import 'package:sudoku/widgets/responsive_screen.dart';
import 'package:sudoku/widgets/square_button.dart';
import 'package:sudoku/widgets/version.dart';

class TitleScreen extends StatefulWidget {
  const TitleScreen({super.key});

  @override
  State<TitleScreen> createState() => _TitleScreenState();
}

class _TitleScreenState extends State<TitleScreen> {
  late AudioSettingsManager audioSettingsManager;
  late SettingsManager settingsManager;

  @override
  void initState() {
    audioSettingsManager = AudioSettingsManager();
    settingsManager = SettingsManager();
    settingsManager.setAudioSettingsManager(audioSettingsManager);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg-blue.png'),
          ),
        ),
        child: ResponsiveScreen(
          bottom: true,
          squarishMainArea: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: size.width * 0.75,
                height: size.height * 0.11,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: SudokuColors.onahu,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Sudoku',
                  style: TextStyle(
                    color: SudokuColors.dodgerBlueDarker,
                    fontSize: 50,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: size.height * 0.34,
                width: size.width * 0.75,
                decoration: BoxDecoration(
                  color: SudokuColors.onahu,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareButton(
                      backgroundColor: SudokuColors.dodgerBlueDarker,
                      borderColor: SudokuColors.dodgerBlueDarker,
                      labelColor: Colors.white,
                      label: 'Jugar',
                      withBackground: true,
                      icon: Image.asset(
                        'assets/icons/gameboy.png',
                        height: 24,
                        //color: SudokuColors.dodgerBlueDarker,
                      ),
                      onTap: () {
                        settingsManager.getAudioSettingsManager().playSelectAudio();
                        Navigator.of(context).push(
                          FadeRoute(
                            page: GameModes(
                              settingsManager: settingsManager,
                            ),
                          ),
                        );
                      },
                    ),
                    SquareButton(
                      backgroundColor: Colors.white,
                      borderColor: SudokuColors.dodgerBlueDarker,
                      labelColor: SudokuColors.dodgerBlueDarker,
                      label: 'Registros',
                      icon: Image.asset(
                        'assets/icons/memory-card2.png',
                        height: 24,
                      ),
                      onTap: () {
                        settingsManager.getAudioSettingsManager().playSelectAudio();
                        Navigator.of(context).push(
                          FadeRoute(page: const RecordsView()),
                        );
                      },
                    ),
                    SquareButton(
                      backgroundColor: Colors.white,
                      borderColor: SudokuColors.dodgerBlueDarker,
                      labelColor: SudokuColors.dodgerBlueDarker,
                      label: 'Ajustes',
                      icon: Image.asset(
                        'assets/icons/settings4.png',
                        height: 24,
                      ),
                      onTap: () {
                        settingsManager.getAudioSettingsManager().playSelectAudio();
                        Navigator.of(context).push(
                          FadeRoute(page: SettingsManagerView(settingsManager: settingsManager)),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          rectangularMenuArea: VersionApp(
            size: Size(
              size.width,
              size.height * 0.07,
            ),
          ),
        ),
      ),
    );
  }
}
