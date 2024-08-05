import 'dart:math';

class SudokuGenerator {
  List<int> sudokuCells = List.filled(81, 0);
  final Random random = Random();

  bool valueIsInRow(int value, int index) {
    int inf = index - index % 9;
    int sup = inf + 8;
    return sudokuCells.sublist(inf, sup + 1).contains(value);
  }

  bool valueIsInCol(int value, int index) {
    for (int i = index % 9; i < 81; i += 9) {
      if (sudokuCells[i] == value) return true;
    }
    return false;
  }

  bool valueIsInSubMatrix(int value, int index) {
    int rowStart = ((index ~/ 9) ~/ 3) * 3;
    int colStart = ((index % 9) ~/ 3) * 3;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (sudokuCells[(rowStart + i) * 9 + (colStart + j)] == value) {
          return true;
        }
      }
    }
    return false;
  }

  bool checkCell(int value, int index) {
    bool isInRow = valueIsInRow(value, index);
    bool isInCol = valueIsInCol(value, index);
    bool isInSubMatrix = valueIsInSubMatrix(value, index);
    return !isInRow && !isInCol && !isInSubMatrix;
  }

  bool solveSudoku(int index) {
    if (index >= 81) return true; // If we've filled all cells, we're done
    if (sudokuCells[index] != 0) return solveSudoku(index + 1); // Skip pre-filled cells

    List<int> numbers = List.generate(9, (i) => i + 1)..shuffle(random); // Randomize the order of numbers
    for (int v in numbers) {
      if (checkCell(v, index)) {
        sudokuCells[index] = v;
        if (solveSudoku(index + 1)) return true;
        sudokuCells[index] = 0; // Reset cell on failure
      }
    }
    return false; // Trigger backtracking
  }

  void addValueInCell(int value, int index) {
    sudokuCells[index] = value;
  }

  void generateSudokuBoard() {
    sudokuCells = List.filled(81, 0);
    // Add a few random numbers to start with to ensure randomness
    for (int i = 0; i < 20; i++) {
      int index = random.nextInt(81);
      int v = random.nextInt(9) + 1;
      if (sudokuCells[index] == 0 && checkCell(v, index)) {
        sudokuCells[index] = v;
      }
    }
    bool res = solveSudoku(0);
    if (!res) {
      generateSudokuBoard();
    }
  }
}
