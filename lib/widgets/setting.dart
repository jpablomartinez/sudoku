import 'package:flutter/material.dart';
import 'package:sudoku/colors.dart';

class Setting extends StatelessWidget {
  final String icon;
  final String title;
  final String label;
  final Widget slider;
  final String actualValue;

  const Setting({
    super.key,
    required this.icon,
    required this.title,
    required this.label,
    required this.slider,
    required this.actualValue,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.85,
      height: size.height * 0.11,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: SudokuColors.onahu.withOpacity(0.7),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xff9FC6F3)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff398BED).withOpacity(0.2),
            offset: const Offset(0, 4),
            blurRadius: 4,
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size.height * 0.1 * 0.55,
            height: size.height * 0.1 * 0.55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xff00ADE3),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xff00ADE3).withOpacity(0.1),
                  offset: const Offset(0, 4),
                  blurRadius: 4,
                )
              ],
            ),
            child: Center(
              child: Image.asset(
                icon,
                color: const Color(
                  0xff398BED,
                ),
                height: 24,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 92,
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: SudokuColors.congressBlue,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.85 * 0.47,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        slider,
                        Text(
                          actualValue,
                          style: const TextStyle(
                            color: SudokuColors.congressBlue,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              SizedBox(
                width: size.width * 0.58,
                child: Text(
                  label,
                  style: const TextStyle(
                    color: SudokuColors.congressBlue,
                    fontSize: 11,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
