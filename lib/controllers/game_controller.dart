import 'dart:math';

import 'package:sudoku/classes/configuration.dart';
import 'package:sudoku/classes/countdown.dart';
import 'package:sudoku/classes/sudoku.dart';
import 'package:sudoku/classes/sudoku_cell.dart';
import 'package:sudoku/controllers/sudoku_generator.dart';
import 'package:sudoku/utils/difficulty.dart';
import 'package:sudoku/utils/game_state.dart';
import 'package:sudoku/utils/states.dart';

class GameController {
  final Random random = Random();
  late Sudoku sudoku;
  late SudokuGenerator sudokuGenerator;
  late Countdown timer;
  Configuration configuration = Configuration(true, false, false, false);
  SudokuDifficulty? difficulty;
  bool showGuideline = false;
  bool availableErrors = true;
  List<SudokuCell> sudokuCells = [];
  int selectedCell = -1;
  bool writeAnnotation = false;
  int remainingEreaseAction = -1;
  int remainingHintsAction = -1;
  List<int> indexVisibleValues = [];
  int countdown = 0;
  GameState state = GameState.play;

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

  void showSudokuBoard() {
    int count = 0;
    int countVisibleValues = 0;
    bool tmp = false;
    for (int i = 0; i < 81; i++) {
      bool show = random.nextBool();
      if (tmp == show) {
        count++;
        if (count == 5) {
          show = !show;
          count = 0;
        }
      } else {
        count = 0;
      }
      if (show && countVisibleValues <= sudoku.maxVisibleValues!) {
        fixValueOnBoard(i);
        countVisibleValues++;
      }
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
    remainingEreaseAction = sudoku.maxEreaseAction!;
    remainingHintsAction = sudoku.availableHints!;
    showSudokuBoard();
    countdown = sudoku.countdown ?? 180;
    timer = Countdown(countdown);
  }

  void clearSelection() {
    for (int i = 0; i < 81; i++) {
      sudokuCells[i].state = SudokuCellState.normal;
    }
  }

  void selectSudokuCell(int index) {
    clearSelection();
    if (configuration.showGuideline!) {
      for (int i = index; i > 0; i -= 9) {
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
    if (remainingEreaseAction > 0 && sudokuCells[selectedCell].canEreaseValue) {
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
          remainingEreaseAction--;
        }
      }
    }
  }

  void writeNumberOnCell(int value) {
    if (sudokuCells[selectedCell].value == 0) {
      if (writeAnnotation) {
        if (sudokuCells[selectedCell].annotations!.length < 4 && !sudokuCells[selectedCell].annotations!.contains(value)) {
          sudokuCells[selectedCell].annotations!.add(value);
        }
      } else {
        sudokuCells[selectedCell].value = value;
        sudokuCells[selectedCell].annotations = [];
      }
    }
  }

  void pauseGame() {
    state = GameState.paused;
  }

  void playGame() {
    state = GameState.play;
  }
}
