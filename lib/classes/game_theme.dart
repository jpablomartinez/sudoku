import 'package:flutter/material.dart';
import 'package:sudoku/colors.dart';

class GameTheme {
  Color primaryColor;
  Color secondaryColor;
  Color thirdColor;
  Color fourthColor;
  String backgroundImage;

  GameTheme.blue({
    this.primaryColor = SudokuColors.dodgerBlueDarker,
    this.secondaryColor = SudokuColors.onahu,
    this.thirdColor = SudokuColors.cerulean,
    this.fourthColor = SudokuColors.congressBlue,
    this.backgroundImage = 'assets/images/bg-blue.png',
  });

  GameTheme.green({
    this.primaryColor = SudokuColors.dodgerBlueDarker,
    this.secondaryColor = SudokuColors.onahu,
    this.thirdColor = SudokuColors.cerulean,
    this.fourthColor = SudokuColors.congressBlue,
    this.backgroundImage = 'assets/images/bg-blue.png',
  });

  GameTheme.purple({
    this.primaryColor = SudokuColors.dodgerBlueDarker,
    this.secondaryColor = SudokuColors.onahu,
    this.thirdColor = SudokuColors.cerulean,
    this.fourthColor = SudokuColors.congressBlue,
    this.backgroundImage = 'assets/images/bg-blue.png',
  });
}
