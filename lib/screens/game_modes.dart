import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sudoku/colors.dart';
import 'package:sudoku/screens/game.dart';
import 'package:sudoku/utils/difficulty.dart';
import 'package:sudoku/utils/time_mode.dart';
import 'package:sudoku/widgets/square_selector_button.dart';

class GameModes extends StatefulWidget {
  const GameModes({super.key});

  @override
  State<GameModes> createState() => _GameModesState();
}

class _GameModesState extends State<GameModes> {
  List<bool> difficulty = [true, false, false];
  List<bool> timeMode = [true, false];

  void setDifficulty(int index) {
    difficulty = [false, false, false];
    setState(() {
      difficulty[index] = true;
    });
  }

  void setTimeMode(int index) {
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
      MaterialPageRoute(
        builder: (context) => GameView(
          difficulty: sudokuDifficulty,
          timeMode: sudokuTimeMode,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg-blue.png'),
            opacity: 0.7,
            fit: BoxFit.contain,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 100,
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
                        ),
                        child: const Center(
                          child: FaIcon(
                            FontAwesomeIcons.arrowLeft,
                            color: SudokuColors.dodgerBlueDarker,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Modos de juego',
                    style: GoogleFonts.gluten(
                      color: SudokuColors.dodgerBlueDarker,
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 15),
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
                        size: Size(size.width * 0.77, size.height * 0.11),
                      ),
                      SquareSeletorButton(
                        title: 'Intermedio',
                        content: '¿Buscas mejorar tus habilidades?\n Prueba este nivel.',
                        backgroundColor: SudokuColors.onahu,
                        borderColor: SudokuColors.cerulean,
                        textColor: SudokuColors.congressBlue,
                        isSelected: difficulty[1],
                        onTap: () => setDifficulty(1),
                        size: Size(size.width * 0.77, size.height * 0.11),
                      ),
                      SquareSeletorButton(
                        title: 'Experto',
                        content: '¿Quieres un desafío? Inténtalo.',
                        backgroundColor: SudokuColors.onahu,
                        borderColor: SudokuColors.cerulean,
                        textColor: SudokuColors.congressBlue,
                        isSelected: difficulty[2],
                        onTap: () => setDifficulty(2),
                        size: Size(size.width * 0.77, size.height * 0.11),
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
                            size: Size(size.width * 0.36, size.height * 0.15),
                          ),
                          SquareSeletorButton(
                            title: 'Hay tiempo',
                            content: 'Sin límite de tiempo para jugar. Ideal para practicar',
                            backgroundColor: SudokuColors.onahu,
                            borderColor: SudokuColors.cerulean,
                            textColor: SudokuColors.congressBlue,
                            isSelected: timeMode[1],
                            onTap: () => setTimeMode(1),
                            size: Size(size.width * 0.36, size.height * 0.15),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              GestureDetector(
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
                    child: Text(
                      'Comenzar',
                      style: GoogleFonts.gluten(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
