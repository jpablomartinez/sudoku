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
    countdown = 180; //im not sure
    maxVisibleValues = maxEasyLevel;
  }

  Sudoku.medium() {
    availableHints = 3;
    maxPossibleErrors = 5;
    countdown = 180; //im not sure
    maxVisibleValues = maxMediumLevel;
  }

  Sudoku.hard() {
    availableHints = 0;
    maxPossibleErrors = 5;
    countdown = 180; //im not sure
    maxVisibleValues = maxHardLevel;
  }

  Sudoku.custom(
    this.maxEreaseAction,
    this.availableHints,
    this.maxPossibleErrors,
    this.countdown,
  );
}
