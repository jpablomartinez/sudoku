import 'dart:math';
import 'package:sudoku/classes/configuration.dart';
import 'package:sudoku/classes/countdown.dart';
import 'package:sudoku/classes/sudoku.dart';
import 'package:sudoku/classes/sudoku_cell.dart';
import 'package:sudoku/controllers/sudoku_generator.dart';
import 'package:sudoku/database/model.dart';
import 'package:sudoku/main.dart';
import 'package:sudoku/utils/difficulty.dart';
import 'package:sudoku/utils/game_state.dart';
import 'package:sudoku/utils/states.dart';
import 'package:vibration/vibration.dart';

class GameController {
  final Random random = Random();
  late Sudoku sudoku;
  late SudokuGenerator sudokuGenerator;
  late Countdown timer;
  Configuration configuration = Configuration(true, true, false, false);
  SudokuDifficulty? difficulty;
  bool showGuideline = false;
  bool availableErrors = true;
  List<SudokuCell> sudokuCells = [];
  int selectedCell = -1;
  bool writeAnnotation = false;
  //int remainingEreaseAction = -1;
  int remainingHintsAction = -1;
  List<int> indexVisibleValues = [];
  int countdown = 0;
  GameState state = GameState.play;
  int opportunities = 0;
  List<bool> availableNumberButtons = [];

  void setGameDifficulty(SudokuDifficulty d) {
    difficulty = d;
    if (difficulty == SudokuDifficulty.easy) {
      sudoku = Sudoku.easy();
    } else if (difficulty == SudokuDifficulty.medium) {
      sudoku = Sudoku.medium();
    } else if (difficulty == SudokuDifficulty.hard) {
      sudoku = Sudoku.hard();
    }
  }

  void prepareSudokuGenerator() {
    sudokuGenerator = SudokuGenerator();
    sudokuGenerator.generateSudokuBoard();
  }

  void showSudokuBoard(int amountVisibleValues) {
    List<int> indexes = List.generate(81, (int index) => index)..shuffle();
    for (int i = 0; i < sudoku.maxVisibleValues!; i++) {
      fixValueOnBoard(indexes.first);
      indexes.removeAt(0);
    }
  }

  void fixValueOnBoard(int index) {
    sudokuCells[index].value = sudokuGenerator.sudokuCells[index];
    sudokuCells[index].canEreaseValue = false;
  }

  GameController(SudokuDifficulty difficulty) {
    setGameDifficulty(difficulty);
    prepareSudokuGenerator();
    sudokuCells = List.generate(81, (int index) => SudokuCell(index, SudokuCellState.normal, annotations: []));
    //remainingEreaseAction = sudoku.maxEreaseAction!;
    remainingHintsAction = sudoku.availableHints!;
    showSudokuBoard(sudoku.maxVisibleValues ?? 37);
    availableNumberButtons = List.generate(9, (int index) => true);
    countdown = sudoku.countdown ?? 180;
    timer = Countdown(countdown);
    opportunities = sudoku.maxPossibleErrors!;
  }

  void clearSelection() {
    for (int i = 0; i < 81; i++) {
      sudokuCells[i].state = SudokuCellState.normal;
    }
  }

  void selectSudokuCell(int index) {
    clearSelection();
    if (configuration.showGuideline!) {
      for (int i = index; i > -1; i -= 9) {
        sudokuCells[i].state = SudokuCellState.hightlight;
      }
      for (int i = index; i < 81; i += 9) {
        sudokuCells[i].state = SudokuCellState.hightlight;
      }
      for (int i = index - (index % 9); i < index - (index % 9) + 9; i++) {
        sudokuCells[i].state = SudokuCellState.hightlight;
      }
      int rowStart = (index ~/ 9) ~/ 3 * 3;
      int colStart = (index % 9) ~/ 3 * 3;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          sudokuCells[(rowStart + i) * 9 + (colStart + j)].state = SudokuCellState.hightlight;
        }
      }
    }
    sudokuCells[index].state = SudokuCellState.selected;
    selectedCell = index;
  }

  void erase() {
    if (sudokuCells[selectedCell].canEreaseValue) {
      if (sudokuCells[selectedCell].annotations!.isNotEmpty) {
        int l = sudokuCells[selectedCell].annotations!.length;
        if (l == 1) {
          sudokuCells[selectedCell].annotations = [];
        } else {
          sudokuCells[selectedCell].annotations = sudokuCells[selectedCell].annotations!.sublist(0, l - 1);
        }
      } else {
        if (sudokuCells[selectedCell].value > 0) {
          sudokuCells[selectedCell].value = 0;
          sudokuCells[selectedCell].badIndex = false;
        }
      }
    }
  }

  void showHint() {
    if (selectedCell != -1) {
      if (sudokuCells[selectedCell].value == 0) {
        sudokuCells[selectedCell].value = sudokuCells[selectedCell].correctValue;
        sudokuCells[selectedCell].canEreaseValue = false;
        sudokuCells[selectedCell].hightlight = true;
        remainingHintsAction--;
      }
    }
  }

  bool countNumbersOnMatrix(int value) {
    return sudokuCells.where((s) => s.value == value).toList().length < 9;
  }

  void writeNumberOnCell(int value, bool canVibrate) {
    if (sudokuCells[selectedCell].value == 0) {
      if (writeAnnotation) {
        if (sudokuCells[selectedCell].annotations!.length < 4 && !sudokuCells[selectedCell].annotations!.contains(value)) {
          sudokuCells[selectedCell].annotations!.add(value);
        }
      } else {
        sudokuCells[selectedCell].value = value;
        sudokuCells[selectedCell].annotations = [];
      }
      bool isWrong = writeAnnotation ? false : checkWrongNumber(value);
      if (isWrong) {
        opportunities--;
        if (canVibrate) {
          vibrate();
        }
        if (opportunities == 0) {
          saveGameResult(lostGame);
          state = GameState.gameover;
        }
        sudokuCells[selectedCell].badIndex = true;
      } else {
        bool won = checkWin();
        if (won) {
          saveGameResult(winGame);
          state = GameState.won;
        }
        for (int i = 0; i < 9; i++) {
          availableNumberButtons[i] = countNumbersOnMatrix(i + 1);
        }
      }
    }
  }

  void pauseGame() {
    state = GameState.paused;
    timer.pause();
  }

  void playGame() {
    state = GameState.play;
  }

  bool valueIsInRow(int value) {
    int inf = selectedCell - selectedCell % 9;
    int sup = inf + 8;
    return sudokuCells.sublist(inf, sup + 1).where((k) => k.value == value).length >= 2;
  }

  bool valueIsInCol(int value) {
    int cnt = 0;
    for (int i = selectedCell % 9; i < 81; i += 9) {
      if (sudokuCells[i].value == value) cnt++;
    }
    return cnt >= 2;
  }

  bool valueIsInSubMatrix(
    int value,
  ) {
    int cnt = 0;
    int rowStart = (selectedCell ~/ 9) ~/ 3 * 3;
    int colStart = (selectedCell % 9) ~/ 3 * 3;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (sudokuCells[(rowStart + i) * 9 + (colStart + j)].value == value) {
          cnt++;
        }
      }
    }
    return cnt == 2;
  }

  bool valueIsCorrect(int value) {
    return value != sudokuCells[selectedCell].correctValue;
  }

  bool checkWin() {
    return sudokuCells.indexWhere((c) => c.value == 0) == -1;
  }

  bool checkWrongNumber(value) {
    //first check configuration
    //if strategic game is active, then only check if value is in row, col or submatrix
    //else check if value is equal to correct value;
    //for now, jump to valueIsCorrect
    //return valueIsInRow(value) || valueIsInCol(value) || valueIsInSubMatrix(value);
    return valueIsCorrect(value);
  }

  bool gameover() {
    return state == GameState.gameover;
  }

  bool wonGame() {
    return state == GameState.won;
  }

  bool isPlaying() {
    return state == GameState.play;
  }

  void restartGame() {}

  String formatTimer(int timer) {
    String m = '${timer ~/ 60}'.padLeft(2, '0');
    String s = '${timer % 60}'.padLeft(2, '0');
    return '$m:$s';
  }

  void stopGame() {
    timer.pause();
    state = GameState.gameover;
  }

  Future<void> vibrate() async {
    if (await Vibration.hasVibrator() != null) {
      Vibration.vibrate(duration: 500);
    }
  }

  void restart() {
    sudokuCells = [];
    prepareSudokuGenerator();
    sudokuCells = List.generate(81, (int index) => SudokuCell(index, SudokuCellState.normal, annotations: []));
    remainingHintsAction = sudoku.availableHints!;
    showSudokuBoard(sudoku.maxVisibleValues ?? 37);
    availableNumberButtons = List.generate(9, (int index) => true);
    countdown = sudoku.countdown ?? 180;
    timer = Countdown(countdown);
    opportunities = sudoku.maxPossibleErrors!;
  }

  String getDifficultyName() {
    return difficulty == SudokuDifficulty.easy
        ? 'easy'
        : difficulty == SudokuDifficulty.medium
            ? 'medium'
            : 'hard';
  }

  void saveGameResult(int result) {
    objectBox.gameDBController.saveResult(
      SudokuStat(
        time: timer.time,
        level: getDifficultyName(),
        result: result,
      ),
    );
  }
}
