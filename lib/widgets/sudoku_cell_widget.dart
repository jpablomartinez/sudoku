import 'package:flutter/material.dart';
import 'package:sudoku/classes/sudoku_cell.dart';
import 'package:sudoku/classes/sudoku_cell_color.dart';
import 'package:sudoku/colors.dart';
import 'package:sudoku/utils/states.dart';

class SudokuCellWidget extends StatelessWidget {
  final SudokuCell sudokuCell;
  final SudokuCellColor sudokuCellColor;
  final Function onTap;
  final bool showGuideLine;

  const SudokuCellWidget({
    super.key,
    required this.sudokuCell,
    required this.sudokuCellColor,
    required this.onTap,
    required this.showGuideLine,
  });

  Widget showAnnotations() {
    if (sudokuCell.annotations!.isNotEmpty) {
      List<Widget> annotations = [];
      for (int n in sudokuCell.annotations!) {
        annotations.add(
          Text(
            '$n',
            style: const TextStyle(
              fontSize: 11,
              color: SudokuColors.rose,
            ),
          ),
        );
      }
      return Row(
        children: annotations,
      );
    }
    return const SizedBox();
  }

  Color getColor() {
    if (sudokuCell.hightlight) {
      return SudokuColors.kGreen;
    } else if (!sudokuCell.canEreaseValue) {
      return const Color.fromARGB(255, 1, 20, 43);
    } else if (sudokuCell.badIndex) {
      return SudokuColors.rose;
    }
    return const Color.fromARGB(255, 40, 114, 216);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: (size.width - 32) / 9,
        height: (size.width - 32) / 9,
        padding: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: sudokuCell.state == SudokuCellState.normal
              ? sudokuCellColor.backgroundColor
              : sudokuCell.state == SudokuCellState.selected
                  ? sudokuCellColor.selectedColor
                  : showGuideLine
                      ? sudokuCellColor.highlightColor
                      : sudokuCellColor.backgroundColor,
          border: Border(
            left: BorderSide(
              color: sudokuCellColor.borderColor,
              width: sudokuCell.index % 9 == 0 ? 3 : 0.5,
            ),
            right: BorderSide(
              color: sudokuCellColor.borderColor,
              width: (sudokuCell.index + 1) % 3 == 0 ? 3 : 0.5,
            ),
            top: BorderSide(
              color: sudokuCellColor.borderColor,
              width: sudokuCell.index < 9 ? 3 : 0.5,
            ),
            bottom: BorderSide(
              color: sudokuCellColor.borderColor,
              width: sudokuCell.index >= 18 && sudokuCell.index < 27 || sudokuCell.index >= 45 && sudokuCell.index < 54 || sudokuCell.index >= 72 && sudokuCell.index < 81 ? 3 : 0.5,
            ),
          ),
        ),
        child: Stack(
          children: [
            showAnnotations(),
            Align(
              alignment: Alignment.center,
              child: sudokuCell.value > 0
                  ? Text(
                      '${sudokuCell.value}',
                      style: TextStyle(
                        fontSize: 27,
                        color: getColor(),
                        fontWeight: !sudokuCell.canEreaseValue ? FontWeight.w400 : FontWeight.w500,
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
