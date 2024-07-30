import 'package:flutter/material.dart';
import 'package:sudoku/colors.dart';
import 'package:sudoku/widgets/triangle_clipper.dart';

class GameAlertDialog extends StatefulWidget {
  final String title;
  final String content;
  final Curve curve;
  final Widget leftButton;
  final Widget rightButton;
  final Function leftAction;
  final Function rightAction;

  const GameAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.curve,
    required this.leftButton,
    required this.rightButton,
    required this.leftAction,
    required this.rightAction,
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
      return Size(s.width * 0.90, s.height * 0.28);
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
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: animation,
          child: Container(
            height: sizeOrientation.height,
            width: sizeOrientation.width,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    /*Positioned(
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
                    ),*/
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
                      alignment: Alignment.center,
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color(0xff104D96),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: sizeOrientation.height - 52,
                  width: sizeOrientation.width,
                  child: Container(
                    decoration: BoxDecoration(
                      color: SudokuColors.onahu.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          height: 3,
                        ),
                        SizedBox(
                          width: sizeOrientation.width * 0.7,
                          child: Text(
                            widget.content,
                            style: const TextStyle(
                              color: Color(0xff236CC3),
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => widget.leftAction(),
                              child: Container(
                                width: sizeOrientation.width * 0.35,
                                height: 34,
                                decoration: BoxDecoration(
                                  color: SudokuColors.onahu,
                                  borderRadius: BorderRadius.circular(15),
                                  /*boxShadow: [
                                    BoxShadow(
                                      color: SudokuColors.onahu.withOpacity(0.25),
                                      offset: Offset(0, 4),
                                      blurRadius: 4,
                                    ),
                                  ],*/
                                ),
                                child: widget.leftButton,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            GestureDetector(
                              onTap: () => widget.rightAction(),
                              child: Container(
                                width: sizeOrientation.width * 0.35,
                                height: 34,
                                decoration: BoxDecoration(
                                  color: const Color(0xff3B95FF),
                                  borderRadius: BorderRadius.circular(15),
                                  /*boxShadow: [
                                    BoxShadow(
                                      color: Color(0xff3B95FF).withOpacity(0.25),
                                      offset: Offset(0, 4),
                                      blurRadius: 4,
                                    ),
                                  ],*/
                                ),
                                child: widget.rightButton,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
