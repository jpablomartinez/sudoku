import 'package:flutter/material.dart';
import 'package:sudoku/colors.dart';

class SettingOptionDialog extends StatelessWidget {
  final String iconPath;
  final String title;
  final double value;
  final double width;
  final Function onChanged;
  final int min;
  final int max;
  final int divisions;

  const SettingOptionDialog({
    super.key,
    required this.iconPath,
    required this.title,
    required this.width,
    required this.value,
    required this.onChanged,
    this.max = 100,
    this.min = 0,
    this.divisions = 10,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Image.asset(
            iconPath,
            color: SudokuColors.congressBlue,
            height: 18,
          ),
          const SizedBox(width: 5),
          SizedBox(
            width: 105,
            child: Text(
              title,
              style: const TextStyle(
                color: SudokuColors.congressBlue,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 25,
            width: width, //size.width * 0.85 - 195,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 10, // Set the height of the track
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
              ),
              child: Slider(
                inactiveColor: const Color(0xffD0D0E4),
                activeColor: const Color(0xff4B9CFA),
                value: value,
                onChanged: (double value) {
                  onChanged(value);
                },
                divisions: divisions == 1 ? null : divisions,
                max: max.toDouble(),
                min: min.toDouble(),
              ),
            ),
          ),
          Text(
            //'${widget.settingsManager.getAudioSettingsManager().getAudioVolume()}',
            divisions == 1
                ? value.toInt() == 2
                    ? 'On'
                    : 'Off'
                : '${value.toInt()}',
            style: const TextStyle(
              color: SudokuColors.congressBlue,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
