import 'package:sudoku/utils/visible_values.dart';

class Sudoku {
  int? maxEreaseAction;
  int? availableHints;
  int? maxPossibleErrors;
  int? countdown;
  int? maxVisibleValues;

  Sudoku.easy() {
    availableHints = 5;
    maxPossibleErrors = 5;
    countdown = 300;
    maxVisibleValues = maxEasyLevel;
  }

  Sudoku.medium() {
    availableHints = 4;
    maxPossibleErrors = 5;
    countdown = 600;
    maxVisibleValues = maxMediumLevel;
  }

  Sudoku.hard() {
    availableHints = 3;
    maxPossibleErrors = 5;
    countdown = 900;
    maxVisibleValues = maxHardLevel;
  }

  Sudoku.custom(
    this.maxEreaseAction,
    this.availableHints,
    this.maxPossibleErrors,
    this.countdown,
  );
}
