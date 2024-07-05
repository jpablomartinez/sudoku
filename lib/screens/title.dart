import 'package:flutter/material.dart';
import 'package:sudoku/colors.dart';
import 'package:sudoku/controllers/audio_controller.dart';
import 'package:sudoku/screens/game_modes.dart';
import 'package:sudoku/widgets/fade_transition.dart';
import 'package:sudoku/widgets/square_button.dart';

class TitleScreen extends StatefulWidget {
  const TitleScreen({super.key});

  @override
  State<TitleScreen> createState() => _TitleScreenState();
}

class _TitleScreenState extends State<TitleScreen> {
  late AudioController audioController;

  @override
  void initState() {
    audioController = AudioController();
    super.initState();
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
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: size.height * 0.24),
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
                      /*border: Border.all(
                        color: SudokuColors.dodgerBlueDarker,
                        width: 3,
                      ),*/
                      borderRadius: BorderRadius.circular(10),
                      /*boxShadow: const [
                        BoxShadow(
                          color: SudokuColors.dodgerBlueDarker,
                          offset: Offset(0, 4),
                        ),
                      ],*/
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SquareButton(
                            backgroundColor: SudokuColors.dodgerBlueDarker,
                            borderColor: SudokuColors.dodgerBlueDarker,
                            labelColor: Colors.white,
                            label: 'Jugar',
                            icon: const Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.white,
                              size: 33,
                            ),
                            onTap: () {
                              //audioController.playSelectAudio();
                              Navigator.of(context).push(
                                FadeRoute(page: const GameModes()),
                              );
                            }),
                        SquareButton(
                          backgroundColor: Colors.white,
                          borderColor: SudokuColors.dodgerBlueDarker,
                          labelColor: SudokuColors.dodgerBlueDarker,
                          label: 'Registros',
                          icon: Image.asset(
                            'assets/icons/game-icon.png',
                            height: 15,
                            color: SudokuColors.dodgerBlueDarker,
                          ),
                          onTap: () {},
                        ),
                        SquareButton(
                          backgroundColor: Colors.white,
                          borderColor: SudokuColors.dodgerBlueDarker,
                          labelColor: SudokuColors.dodgerBlueDarker,
                          label: 'Ajustes',
                          icon: Image.asset(
                            'assets/icons/settings.png',
                            height: 20,
                            color: SudokuColors.dodgerBlueDarker,
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: size.width,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: const Text(
                  'JK STUDIOS - versión 0.3',
                  style: TextStyle(
                    fontSize: 14,
                    color: SudokuColors.dodgerBlueDarker,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
