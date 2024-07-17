import 'package:flutter/material.dart';
import 'package:sudoku/colors.dart';

class RecordInfo extends StatelessWidget {
  final String icon;
  final String label;
  final String amount;
  final Color chipColor;
  final Size size;

  const RecordInfo({
    super.key,
    required this.icon,
    required this.label,
    required this.amount,
    required this.chipColor,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 50,
      alignment: Alignment.centerLeft,
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                icon,
                height: 22,
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 22,
                child: Center(
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: SudokuColors.congressBlue,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 25,
            width: 77,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: chipColor,
            ),
            child: Center(
              child: Text(
                amount,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
