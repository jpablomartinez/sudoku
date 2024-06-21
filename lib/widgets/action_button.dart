import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sudoku/colors.dart';

class ActionButton extends StatelessWidget {
  final Color backgroundColor;
  final Widget icon;
  final Function onTap;
  final int remainingAction;

  const ActionButton({
    super.key,
    required this.backgroundColor,
    required this.icon,
    required this.onTap,
    this.remainingAction = -1,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 60,
        alignment: Alignment.center,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 56,
              height: 56,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: icon,
              ),
            ),
            remainingAction > -1
                ? Positioned(
                    right: 0,
                    top: -5,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(
                        color: SudokuColors.rose,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: DefaultTextStyle(
                          style: GoogleFonts.averiaGruesaLibre(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          child: Text('$remainingAction'),
                        ),
                      ),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
