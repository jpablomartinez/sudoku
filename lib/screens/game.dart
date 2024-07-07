import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:sudoku/classes/settings_manager.dart';
import 'package:sudoku/classes/sudoku_cell_color.dart';
import 'package:sudoku/colors.dart';
import 'package:sudoku/controllers/game_controller.dart';
import 'package:sudoku/utils/difficulty.dart';
import 'package:sudoku/utils/game_state.dart';
import 'package:sudoku/utils/time_mode.dart';
import 'package:sudoku/widgets/action_button.dart';
import 'package:sudoku/widgets/end_game_dialog.dart';
import 'package:sudoku/widgets/game_alert_dialog.dart';
import 'package:sudoku/widgets/number_button.dart';
import 'package:sudoku/widgets/rounded_button.dart';
import 'package:sudoku/widgets/setting_option_dialog.dart';
import 'package:sudoku/widgets/settings_dialog.dart';
import 'package:sudoku/widgets/star.dart';
import 'package:sudoku/widgets/sudoku_cell_widget.dart';

class GameView extends StatefulWidget {
  final SudokuDifficulty difficulty;
  final SudokuTimeMode timeMode;
  final SettingsManager settingsManager;
  const GameView({
    super.key,
    required this.difficulty,
    required this.timeMode,
    required this.settingsManager,
  });

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  late GameController gameController;
  Widget stars = const SizedBox();
  Widget board = const SizedBox();
  String timer = '00:00';
  Widget numberOptions = const SizedBox();

  void prepareGame() {
    gameController = GameController(widget.difficulty);
    board = createSudokuBoard();
    stars = getStars();
    numberOptions = createNumberButtons();
  }

  void startGame() {
    if (widget.timeMode == SudokuTimeMode.timer) {
      gameController.timer.startTimer(const Duration(seconds: 1), () {
        setState(() {
          timer = gameController.formatTimer(gameController.timer.time);
        });
      });
    } else {
      gameController.timer.startCountdown(const Duration(seconds: 1), () {
        setState(() {
          timer = gameController.formatTimer(gameController.timer.remaining);
        });
        if (gameController.timer.remaining == 0) {
          gameController.stopGame();
          openGameOverDialog();
        }
      });
    }
  }

  @override
  void initState() {
    prepareGame();
    startGame();
    super.initState();
  }

  Size getSizeForDialog(double percentageWidth, double percentageHeight) {
    Size size = MediaQuery.of(context).size;
    return Size(size.width * percentageWidth, size.height * percentageHeight);
  }

  void pauseGame() {
    setState(() {
      gameController.state = GameState.paused;
    });
    gameController.pauseGame();
  }

  void playGame() {
    setState(() {
      gameController.state = GameState.play;
    });
    startGame();
  }

  void erase() {
    widget.settingsManager.getAudioSettingsManager().playEraseAudio();
    if (gameController.isPlaying()) {
      gameController.erase();
      setState(() {
        board = createSudokuBoard();
      });
    }
  }

  void useHint() {
    widget.settingsManager.getAudioSettingsManager().playHintAudio();
    if (gameController.isPlaying()) {
      if (gameController.remainingHintsAction > 0) {
        gameController.showHint();
        setState(() {
          board = createSudokuBoard();
        });
      } else {
        //show alert and (vibrate ?)
      }
    } else {
      //show alert and (vibrate ?)
    }
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
    widget.settingsManager.getAudioSettingsManager().playWriteNumberAudio();
    if (gameController.isPlaying()) {
      gameController.writeNumberOnCell(value, widget.settingsManager.getCanVibrate());
      setState(() {
        board = createSudokuBoard();
        numberOptions = createNumberButtons();
      });
      if (gameController.gameover()) {
        gameController.stopGame();
        openGameOverDialog();
      } else if (gameController.wonGame()) {
        gameController.stopGame();
        openWinDialog();
      }
      setState(() {
        stars = getStars();
      });
    } else {
      //show alert
    }
  }

  void closeDialog() {
    playGame();
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
            showGuideLine: widget.settingsManager.getVisualGuide(),
            onTap: () => selectSudokuCell(9 * i + j),
          ),
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
    for (int i = 0; i < 9; i++) {
      rows.add(
        NumberButton(
          value: i + 1,
          onTap: () => writeNumberOnCell(i + 1),
          active: gameController.availableNumberButtons[i],
        ),
      );
      if (i == 4 || i == 8) {
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

  Widget getStars() {
    List<Widget> stars = [];
    for (int i = gameController.sudoku.maxPossibleErrors!; i > 0; i--) {
      if (i > gameController.opportunities) {
        stars.add(const StarWidget(
          isFull: false,
          height: 18,
        ));
      } else {
        stars.add(const StarWidget(
          isFull: true,
          height: 18,
        ));
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: stars,
    );
  }

  void endGame() {
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void restartGame() {
    gameController.restart();
    prepareGame();
    startGame();
    Navigator.pop(context);
  }

  String getUseTime() {
    if (widget.timeMode == SudokuTimeMode.timer) {
      return timer;
    }
    return gameController.formatTimer(gameController.sudoku.countdown! - gameController.timer.remaining);
  }

  Future<void> openWinDialog() {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return EndgameDialog(
          title: '¡HAS GANADO!',
          time: getUseTime(),
          imgPath: 'assets/images/blueWin.jpg',
          points: gameController.opportunities,
          primaryColor: SudokuColors.dodgerBlueDarker,
          secondaryColor: SudokuColors.onahu,
          imgSize: getSizeForDialog(0.74, 0.22),
          dialogSize: getSizeForDialog(0.93, 0.58),
          curve: Curves.easeOutQuint,
          rightButton: () => restartGame(),
          leftButton: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
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
          time: getUseTime(),
          imgPath: 'assets/images/red-gameover.jpg',
          points: 0,
          primaryColor: SudokuColors.rose,
          secondaryColor: SudokuColors.roseBud,
          imgSize: getSizeForDialog(0.74, 0.25),
          dialogSize: getSizeForDialog(0.93, 0.58),
          rightButton: () => restartGame(),
          leftButton: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          maxPoints: 5, //gameController.sudoku.maxPossibleErrors!,
        );
      },
    );
  }

  Future<void> openEndgameDialog() {
    if (gameController.state == GameState.play) {
      pauseGame();
    }
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return GameAlertDialog(
          title: 'SUDOKU',
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
                      child: const Center(
                        child: Text(
                          'NO',
                          style: TextStyle(
                            fontSize: 16,
                            color: SudokuColors.rose,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => endGame(),
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: SudokuColors.congressBlue),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'SI',
                          style: TextStyle(
                            fontSize: 16,
                            color: SudokuColors.congressBlue,
                          ),
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

  Future<void> openSettingsDialog(Size size) {
    if (gameController.state == GameState.play) {
      pauseGame();
    }
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SettingsDialog(
              widget: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SettingOptionDialog(
                        iconPath: 'assets/icons/audio.png',
                        title: 'Sonido',
                        width: size.width * 0.85 - 195,
                        onChanged: (double value) {
                          setState(() {
                            widget.settingsManager.getAudioSettingsManager().setAudioVolume(value.toInt());
                          });
                        },
                        value: widget.settingsManager.getAudioSettingsManager().getAudioVolume().toDouble(),
                      ),
                      SettingOptionDialog(
                        iconPath: 'assets/icons/music.png',
                        title: 'Música',
                        width: size.width * 0.85 - 195,
                        onChanged: (double value) {
                          setState(() {
                            widget.settingsManager.getAudioSettingsManager().setBackgroundVolume(value.toInt());
                          });
                        },
                        value: widget.settingsManager.getAudioSettingsManager().getBackgroundVolume().toDouble(),
                      ),
                      SettingOptionDialog(
                        iconPath: 'assets/icons/audio.png',
                        title: 'Guía visual',
                        width: size.width * 0.85 * 0.21,
                        onChanged: (double value) {
                          setState(() {
                            widget.settingsManager.setVisualGuide(value == 2);
                          });
                        },
                        min: 1,
                        max: 2,
                        divisions: 1,
                        value: widget.settingsManager.getVisualGuide() ? 2 : 1,
                      ),
                      SettingOptionDialog(
                        iconPath: 'assets/icons/music.png',
                        title: 'Vibrar',
                        onChanged: (double value) {
                          setState(() {
                            widget.settingsManager.setCanVibrate(value == 2);
                          });
                        },
                        min: 1,
                        max: 2,
                        divisions: 1,
                        width: size.width * 0.85 * 0.21,
                        value: widget.settingsManager.getCanVibrate() ? 2 : 1,
                      ),
                      SettingOptionDialog(
                        iconPath: 'assets/icons/audio.png',
                        title: 'Guardar',
                        onChanged: (double value) {
                          setState(() {
                            widget.settingsManager.setSaveOnExit(value == 2);
                          });
                        },
                        min: 1,
                        max: 2,
                        divisions: 1,
                        width: size.width * 0.85 * 0.21,
                        value: widget.settingsManager.getSaveOnExit() ? 2 : 1,
                      ),
                    ],
                  ),
                ],
              ),
              backButton: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 155,
                  height: 48,
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: SudokuColors.dodgerBlueDarker,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/arrow2.png',
                        height: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Volver',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              curve: Curves.easeOutQuint,
            );
          },
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
              color: SudokuColors.dodgerBlue.withOpacity(0.90),
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
                    SizedBox(height: size.height * 0.06),
                    Row(
                      children: [
                        RoundedButton(
                          icon: Image.asset(
                            'assets/icons/home.png',
                            width: 22,
                          ),
                          onTap: () async {
                            await openEndgameDialog();
                          },
                          size: const Size(42, 42),
                        ),
                        const Spacer(),
                        Text(
                          timer,
                          style: const TextStyle(color: Colors.white, fontSize: 33),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            RoundedButton(
                              icon: gameController.state == GameState.play
                                  ? Image.asset(
                                      'assets/icons/pause2.png',
                                      width: 12,
                                      color: SudokuColors.cerulean,
                                    )
                                  : Transform.rotate(
                                      angle: math.pi,
                                      child: Image.asset(
                                        'assets/icons/play2.png',
                                        height: 18,
                                        color: SudokuColors.cerulean,
                                      ),
                                    ),
                              onTap: () {
                                if (gameController.state == GameState.play) {
                                  pauseGame();
                                } else if (gameController.state == GameState.paused) {
                                  playGame();
                                }
                              },
                              size: const Size(42, 42),
                            ),
                            RoundedButton(
                              icon: Image.asset(
                                'assets/icons/settings2.png',
                                color: SudokuColors.cerulean,
                                width: 22,
                              ),
                              onTap: () => openSettingsDialog(size),
                              size: const Size(42, 42),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Dificultad: ${showDifficculty()}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        stars,
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
                          remainingAction: gameController.remainingHintsAction,
                          onTap: () => useHint(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: size.width,
                      child: numberOptions,
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
