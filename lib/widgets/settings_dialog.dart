import 'package:flutter/material.dart';
import 'package:sudoku/colors.dart';

class SettingsDialog extends StatefulWidget {
  final Widget widget;
  final Curve curve;
  final Widget backButton;

  const SettingsDialog({
    super.key,
    required this.widget,
    required this.curve,
    required this.backButton,
  });

  @override
  State<SettingsDialog> createState() => _AlertDialogState();
}

class _AlertDialogState extends State<SettingsDialog> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 750));
    animation = CurvedAnimation(parent: animationController, curve: widget.curve);
    animationController.addListener(() {
      setState(() {});
    });
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Size getSizeOrientationMobile(Size s) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return Size(s.width * 0.9, s.height * 0.55);
    } else {
      return Size(360, s.height * 0.75);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Size sizeOrientation = getSizeOrientationMobile(size);

    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: animation,
          child: Container(
            height: sizeOrientation.height,
            width: sizeOrientation.width,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'Ajustes',
                    style: TextStyle(fontSize: 22, color: SudokuColors.dodgerBlueDarker),
                  ),
                  SizedBox(
                    height: sizeOrientation.height * 0.65,
                    width: sizeOrientation.width,
                    child: Container(
                      decoration: BoxDecoration(
                        color: SudokuColors.onahu.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          widget.widget,
                          Container(
                            alignment: Alignment.center,
                            child: const Text(
                              'JK STUDIOS - Version 0.4.1',
                              style: TextStyle(
                                color: SudokuColors.congressBlue,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  widget.backButton,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
