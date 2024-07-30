import 'package:flutter/material.dart';
import 'package:sudoku/colors.dart';
import 'package:sudoku/widgets/triangle_clipper.dart';
import 'package:sudoku/widgets/version.dart';

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
      return Size(s.width * 0.9, s.height * 0.50);
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
            height: sizeOrientation.height * 0.82,
            width: sizeOrientation.width,
            //padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: SizedBox(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        left: sizeOrientation.width / 2 - 10,
                        bottom: -20,
                        child: ClipPath(
                          clipper: TriangleClipper(),
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color: const Color(0xff4B9CFA).withOpacity(0.8),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        width: sizeOrientation.width,
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xff4B9CFA).withOpacity(0.7),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(width: 1),
                            const Text(
                              'Ajustes',
                              style: TextStyle(
                                fontSize: 22,
                                color: Color(0xff104D96),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            widget.backButton,
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: sizeOrientation.height * 0.82 - 52,
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
                              'JK STUDIOS - Version $version',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
