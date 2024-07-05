import 'package:flutter/material.dart';
import 'package:sudoku/colors.dart';

class GameAlertDialog extends StatefulWidget {
  final String title;
  final String content;
  final Widget widget;
  final String imgPath;
  final Curve curve;

  const GameAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.widget,
    required this.curve,
    required this.imgPath,
  });

  @override
  State<GameAlertDialog> createState() => _AlertDialogState();
}

class _AlertDialogState extends State<GameAlertDialog> with SingleTickerProviderStateMixin {
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
      return Size(s.width * 0.78, 385);
    } else {
      return Size(360, s.height * 0.75);
    }
  }

  Size getSizeImageOrientationMobile(Size s) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return Size(s.width * 0.85 * 0.7, 200);
    } else {
      return Size(s.height * 0.60, 140);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Size sizeOrientation = getSizeOrientationMobile(size);
    Size imageOrientation = getSizeImageOrientationMobile(size);
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
                  Text(
                    widget.title,
                    style: const TextStyle(fontSize: 20, color: SudokuColors.dodgerBlueDarker),
                  ),
                  widget.imgPath != ''
                      ? Center(
                          child: Image.asset(
                            widget.imgPath,
                            width: imageOrientation.width,
                            height: imageOrientation.height,
                            fit: BoxFit.contain,
                          ),
                        )
                      : const SizedBox(),
                  Text(
                    widget.content,
                    style: const TextStyle(fontSize: 18, color: SudokuColors.dodgerBlueDarker),
                  ),
                  const SizedBox(height: 15),
                  widget.widget,
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
