import 'package:sudoku/utils/visible_values.dart';

class Sudoku {
  int? maxEreaseAction;
  int? availableHints;
  int? maxPossibleErrors;
  int? countdown;
  int? maxVisibleValues;

  Sudoku.easy() {
    maxEreaseAction = 5;
    availableHints = 5;
    maxPossibleErrors = 3;
    countdown = 180; //im not sure
    maxVisibleValues = maxEasyLevel;
  }

  Sudoku.medium() {
    maxEreaseAction = 4;
    availableHints = 3;
    maxPossibleErrors = 3;
    countdown = 180; //im not sure
    maxVisibleValues = maxMediumLevel;
  }

  Sudoku.hard() {
    maxEreaseAction = 3;
    availableHints = 0;
    maxPossibleErrors = 2;
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
