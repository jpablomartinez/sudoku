import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sudoku/classes/sudoku_cell_color.dart';
import 'package:sudoku/colors.dart';
import 'package:sudoku/controllers/game_controller.dart';
import 'package:sudoku/utils/difficulty.dart';
import 'package:sudoku/utils/time_mode.dart';
import 'package:sudoku/widgets/action_button.dart';
import 'package:sudoku/widgets/end_game_dialog.dart';
import 'package:sudoku/widgets/game_alert_dialog.dart';
import 'package:sudoku/widgets/number_button.dart';
import 'package:sudoku/widgets/rounded_button.dart';
import 'package:sudoku/widgets/sudoku_cell_widget.dart';

class GameView extends StatefulWidget {
  final SudokuDifficulty difficulty;
  final SudokuTimeMode timeMode;
  const GameView({
    super.key,
    required this.difficulty,
    required this.timeMode,
  });

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  late GameController gameController;
  Widget board = const SizedBox();
  String timer = '00:00';

  @override
  void initState() {
    gameController = GameController(widget.difficulty);
    board = createSudokuBoard();
    /*gameController.timer.startCountdown(const Duration(seconds: 1), () {
      setState(() {
        timer = formatTimer(gameController.timer.remaining);
      });
    });*/
    super.initState();
  }

  Size getSizeForDialog(double percentageWidth, double percentageHeight) {
    Size size = MediaQuery.of(context).size;
    return Size(size.width * percentageWidth, size.height * percentageHeight);
  }

  String formatTimer(int timer) {
    String m = '${timer ~/ 60}'.padLeft(2, '0');
    String s = '${timer % 60}'.padLeft(2, '0');
    return '$m:$s';
  }

  void erase() {
    gameController.erase();
    setState(() {
      board = createSudokuBoard();
    });
  }

  void selectSudokuCell(int index) {
    gameController.selectSudokuCell(index);
    setState(() {
      board = createSudokuBoard();
    });
  }

  void changeWriteAnnotation() {
    setState(() {
      gameController.writeAnnotation = !gameController.writeAnnotation;
    });
  }

  void writeNumberOnCell(int value) {
    gameController.writeNumberOnCell(value);
    setState(() {
      board = createSudokuBoard();
    });
  }

  void closeDialog() {
    gameController.playGame();
    Navigator.pop(context);
  }

  Widget createSudokuBoard() {
    List<Widget> row = [];
    List<Widget> column = [];
    for (int i = 0; i < 9; i++) {
      row = [];
      for (int j = 0; j < 9; j++) {
        row.add(
          SudokuCellWidget(
              sudokuCell: gameController.sudokuCells[9 * i + j],
              sudokuCellColor: SudokuCellColor(
                SudokuColors.onahu,
                SudokuColors.cerulean,
                SudokuColors.freshAir,
                SudokuColors.malibuDarker,
              ),
              onTap: () => selectSudokuCell(9 * i + j)),
        );
      }
      column.add(Row(
        children: row,
      ));
    }
    return Column(
      children: column,
    );
  }

  Widget createNumberButtons() {
    List<Widget> rows = [];
    List<Widget> column = [];
    for (int i = 1; i <= 9; i++) {
      rows.add(
        NumberButton(
          value: i,
          onTap: () => writeNumberOnCell(i),
        ),
      );
      if (i == 5 || i == 9) {
        column.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: rows,
          ),
        );
        rows = [];
      }
    }
    return Column(
      children: column,
    );
  }

  String showDifficculty() {
    if (gameController.difficulty == SudokuDifficulty.easy) {
      return 'Principiante';
    } else if (gameController.difficulty == SudokuDifficulty.medium) {
      return 'Intermedio';
    } else if (gameController.difficulty == SudokuDifficulty.hard) {
      return 'Experto';
    } else {
      return 'Custom';
    }
  }

  Future<void> openWinDialog() {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return EndgameDialog(
          title: '¡HAS GANADO!',
          time: '01:22',
          imgPath: 'assets/images/blueWin.jpg',
          points: 3,
          primaryColor: SudokuColors.dodgerBlueDarker,
          secondaryColor: SudokuColors.onahu,
          imgSize: getSizeForDialog(0.74, 0.22),
          dialogSize: getSizeForDialog(0.93, 0.58),
          curve: Curves.easeOutQuint,
          rightButton: () {},
          leftButton: () {},
          maxPoints: 5,
        );
      },
    );
  }

  Future<void> openGameOverDialog() {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return EndgameDialog(
          curve: Curves.easeOutQuint,
          title: '¡HAS PERDIDO!',
          time: '01:22',
          imgPath: 'assets/images/red-gameover.jpg',
          points: 0,
          primaryColor: SudokuColors.rose,
          secondaryColor: SudokuColors.roseBud,
          imgSize: getSizeForDialog(0.74, 0.25),
          dialogSize: getSizeForDialog(0.93, 0.58),
          leftButton: () {},
          rightButton: () {},
          maxPoints: 5, //gameController.sudoku.maxPossibleErrors!,
        );
      },
    );
  }

  Future<void> openEndgameDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return GameAlertDialog(
          title: 'SUDOKU MENÚ',
          content: '¿Deseas salir del juego actual?',
          imgPath: 'assets/images/menu.png',
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => closeDialog(),
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: SudokuColors.rose),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: DefaultTextStyle(
                          style: GoogleFonts.gluten(
                            fontSize: 16,
                            color: SudokuColors.rose,
                          ),
                          child: const Text('NO'),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: SudokuColors.congressBlue),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: DefaultTextStyle(
                          style: GoogleFonts.gluten(
                            fontSize: 16,
                            color: SudokuColors.congressBlue,
                          ),
                          child: const Text('SI'),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          curve: Curves.easeOutQuint,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg-blue.png'),
          ),
        ),
        child: Stack(
          children: [
            Container(
              height: size.height * 0.4,
              color: SudokuColors.dodgerBlue.withOpacity(0.82),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                width: size.width,
                child: Column(
                  children: [
                    const SizedBox(height: 70),
                    Row(
                      children: [
                        RoundedButton(
                          icon: Image.asset(
                            'assets/icons/home.png',
                            width: 22,
                          ),
                          onTap: () async {
                            gameController.pauseGame();
                            await openWinDialog();
                          },
                          size: const Size(42, 42),
                        ),
                        const Spacer(),
                        DefaultTextStyle(
                          style: GoogleFonts.gluten(color: Colors.white, fontSize: 33),
                          child: Text(timer),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            RoundedButton(
                              icon: Image.asset(
                                'assets/icons/pause.png',
                                width: 12,
                              ),
                              onTap: () {},
                              size: const Size(42, 42),
                            ),
                            RoundedButton(
                              icon: Image.asset(
                                'assets/icons/settings.png',
                                width: 22,
                              ),
                              onTap: () {},
                              size: const Size(42, 42),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        DefaultTextStyle(
                          style: GoogleFonts.gluten(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          child: Text('Dificultad: ${showDifficculty()}'),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    board,
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ActionButton(
                          backgroundColor: SudokuColors.onahu,
                          icon: Image.asset('assets/icons/erase.png', width: 24),
                          remainingAction: gameController.remainingEreaseAction,
                          onTap: () => erase(),
                        ),
                        ActionButton(
                          backgroundColor: gameController.writeAnnotation ? SudokuColors.malibu : SudokuColors.onahu,
                          icon: Image.asset('assets/icons/pencil.png', width: 28),
                          onTap: () => changeWriteAnnotation(),
                        ),
                        ActionButton(
                          backgroundColor: SudokuColors.onahu,
                          icon: Image.asset('assets/icons/hint.png', width: 25),
                          remainingAction: 3,
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: size.width,
                      child: createNumberButtons(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
