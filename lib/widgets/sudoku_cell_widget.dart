import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sudoku/classes/sudoku_cell.dart';
import 'package:sudoku/classes/sudoku_cell_color.dart';
import 'package:sudoku/colors.dart';
import 'package:sudoku/utils/states.dart';

class SudokuCellWidget extends StatelessWidget {
  final SudokuCell sudokuCell;
  final SudokuCellColor sudokuCellColor;
  final Function onTap;

  const SudokuCellWidget({
    super.key,
    required this.sudokuCell,
    required this.sudokuCellColor,
    required this.onTap,
  });

  Widget showAnnotations() {
    if (sudokuCell.annotations!.isNotEmpty) {
      List<Widget> annotations = [];
      for (int n in sudokuCell.annotations!) {
        annotations.add(
          DefaultTextStyle(
            style: GoogleFonts.gluten(
              fontSize: 11,
              color: SudokuColors.rose,
            ),
            child: Text('$n'),
          ),
        );
      }
      return Row(
        children: annotations,
      );
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: 44,
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: sudokuCell.state == SudokuCellState.normal
              ? sudokuCellColor.backgroundColor
              : sudokuCell.state == SudokuCellState.selected
                  ? sudokuCellColor.selectedColor
                  : sudokuCellColor.highlightColor,
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
              child: DefaultTextStyle(
                style: GoogleFonts.gluten(
                  fontSize: 27,
                  color: SudokuColors.congressBlue,
                ),
                child: sudokuCell.value > 0 ? Text('${sudokuCell.value}') : const SizedBox(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
