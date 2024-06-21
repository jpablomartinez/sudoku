import 'package:sudoku/utils/states.dart';

class SudokuCell {
  int value;
  int index;
  List<int>? annotations;
  SudokuCellState state;
  bool canEreaseValue;

  SudokuCell(
    this.index,
    this.state, {
    this.value = 0,
    this.annotations,
    this.canEreaseValue = true,
  });
}
