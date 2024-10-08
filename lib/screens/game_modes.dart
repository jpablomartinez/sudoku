import 'package:flutter/material.dart';
import 'package:sudoku/classes/settings_manager.dart';
import 'package:sudoku/colors.dart';
import 'package:sudoku/screens/game.dart';
import 'package:sudoku/utils/difficulty.dart';
import 'package:sudoku/utils/time_mode.dart';
import 'package:sudoku/widgets/arrow_back.dart';
import 'package:sudoku/widgets/fade_transition.dart';
import 'package:sudoku/widgets/responsive_screen.dart';
import 'package:sudoku/widgets/square_selector_button.dart';
import 'package:sudoku/widgets/title_screen.dart';

class GameModes extends StatefulWidget {
  final SettingsManager settingsManager;
  const GameModes({
    super.key,
    required this.settingsManager,
  });

  @override
  State<GameModes> createState() => _GameModesState();
}

class _GameModesState extends State<GameModes> {
  List<bool> difficulty = [true, false, false];
  List<bool> timeMode = [true, false];

  void setDifficulty(int index) {
    widget.settingsManager.getAudioSettingsManager().playGameModeAudio();
    difficulty = [false, false, false];
    setState(() {
      difficulty[index] = true;
    });
  }

  void setTimeMode(int index) {
    widget.settingsManager.getAudioSettingsManager().playGameModeAudio();
    timeMode = [false, false];
    setState(() {
      timeMode[index] = true;
    });
  }

  void startGame() {
    SudokuDifficulty sudokuDifficulty = difficulty[0]
        ? SudokuDifficulty.easy
        : difficulty[1]
            ? SudokuDifficulty.medium
            : SudokuDifficulty.hard;
    SudokuTimeMode sudokuTimeMode = timeMode[0] ? SudokuTimeMode.countdown : SudokuTimeMode.timer;
    Navigator.of(context).push(
      FadeRoute(
        page: GameView(
          difficulty: sudokuDifficulty,
          timeMode: sudokuTimeMode,
          settingsManager: widget.settingsManager,
        ),
      ),
    );
  }

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
                  const TitleScreen(title: 'Modos de juego'),
                  const SizedBox(),
                ],
              ),
              const SizedBox(height: 30),
              Column(
                children: [
                  SquareSeletorButton(
                    title: 'Principiante',
                    content: '¿Estás aprendiendo Sudoku?\n Este nivel es para ti.',
                    backgroundColor: SudokuColors.onahu,
                    borderColor: SudokuColors.cerulean,
                    textColor: SudokuColors.congressBlue,
                    isSelected: difficulty[0],
                    onTap: () => setDifficulty(0),
                    size: Size(size.width * 0.80, size.height * 0.12),
                  ),
                  SquareSeletorButton(
                    title: 'Intermedio',
                    content: '¿Buscas mejorar tus habilidades?\n Prueba este nivel.',
                    backgroundColor: SudokuColors.onahu,
                    borderColor: SudokuColors.cerulean,
                    textColor: SudokuColors.congressBlue,
                    isSelected: difficulty[1],
                    onTap: () => setDifficulty(1),
                    size: Size(size.width * 0.80, size.height * 0.12),
                  ),
                  SquareSeletorButton(
                    title: 'Experto',
                    content: '¿Quieres un desafío? Inténtalo.',
                    backgroundColor: SudokuColors.onahu,
                    borderColor: SudokuColors.cerulean,
                    textColor: SudokuColors.congressBlue,
                    isSelected: difficulty[2],
                    onTap: () => setDifficulty(2),
                    size: Size(size.width * 0.80, size.height * 0.12),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SquareSeletorButton(
                        title: 'Contrareloj',
                        content: 'Gana antes de que termine el tiempo. Solo para valientes',
                        backgroundColor: SudokuColors.onahu,
                        borderColor: SudokuColors.cerulean,
                        textColor: SudokuColors.congressBlue,
                        isSelected: timeMode[0],
                        onTap: () => setTimeMode(0),
                        size: Size(size.width * 0.38, size.height * 0.17),
                      ),
                      SquareSeletorButton(
                        title: 'Hay tiempo',
                        content: 'Sin límite de tiempo para jugar. Ideal para practicar',
                        backgroundColor: SudokuColors.onahu,
                        borderColor: SudokuColors.cerulean,
                        textColor: SudokuColors.congressBlue,
                        isSelected: timeMode[1],
                        onTap: () => setTimeMode(1),
                        size: Size(size.width * 0.38, size.height * 0.17),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          rectangularMenuArea: GestureDetector(
            onTap: () => startGame(),
            child: Container(
              width: size.width * 0.77,
              height: size.height * 0.07,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: SudokuColors.dodgerBlueDarker,
              ),
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  'Comenzar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
