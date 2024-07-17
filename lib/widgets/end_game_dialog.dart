import 'package:flutter/material.dart';
import 'package:sudoku/colors.dart';
import 'package:sudoku/widgets/star.dart';

class EndgameDialog extends StatefulWidget {
  final String title;
  final String time;
  final int points;
  final Color primaryColor;
  final Color secondaryColor;
  final Color leftButtonColor;
  final Color rightButtonColor;
  final Color titleColor;
  final Size dialogSize;
  final Curve curve;
  final Function leftButton;
  final Function rightButton;
  final int maxPoints;
  final String message;
  final Color decorator;

  const EndgameDialog({
    super.key,
    required this.title,
    required this.time,
    required this.points,
    required this.primaryColor,
    required this.secondaryColor,
    required this.leftButtonColor,
    required this.rightButtonColor,
    required this.titleColor,
    required this.dialogSize,
    required this.curve,
    required this.leftButton,
    required this.rightButton,
    required this.maxPoints,
    this.decorator = const Color(0xffA765E8),
    this.message = '¡Reinténtalo!',
  });

  @override
  State<EndgameDialog> createState() => _EndgameDialogState();
}

class _EndgameDialogState extends State<EndgameDialog> with SingleTickerProviderStateMixin {
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

  Widget getStars() {
    List<Widget> stars = [];
    double left = 10;
    double top = widget.dialogSize.height * 0.29 - 40;
    double height = 40;
    int j = 0;
    for (int i = 0; i < widget.maxPoints; i++) {
      stars.add(
        Positioned(
          top: top,
          left: left,
          child: StarWidget(
            height: height,
            isFull: i < widget.points ? true : false,
          ),
        ),
      );
      left += height + 10;
      height += 13;
      top -= 38;
      j++;
      if (j > 2) {
        height -= 26;
        top += 76;
      }
    }
    return Stack(
      children: stars,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: animation,
          child: Container(
            height: widget.dialogSize.height,
            width: widget.dialogSize.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 13),
                    Text(
                      widget.title,
                      style: TextStyle(
                        color: widget.titleColor,
                        fontSize: 45,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      height: widget.dialogSize.height * 0.35,
                      width: widget.dialogSize.width * 0.8,
                      child: getStars(),
                    ),
                    const SizedBox(height: 5),
                    Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: widget.dialogSize.width * 0.65,
                          height: 67,
                          decoration: BoxDecoration(
                            color: SudokuColors.onahu.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: SudokuColors.onahu.withOpacity(0.25),
                                offset: const Offset(0, 4),
                                blurRadius: 4,
                              )
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'Tiempo usado: ${widget.time}',
                              style: TextStyle(
                                color: widget.primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: -17,
                          child: Container(
                            width: widget.dialogSize.width * 0.65 * 0.58,
                            height: 34,
                            decoration: BoxDecoration(
                              color: widget.decorator,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                widget.message,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => widget.leftButton(),
                      child: Container(
                        height: 79,
                        width: widget.dialogSize.width / 2,
                        decoration: BoxDecoration(
                          color: widget.leftButtonColor,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                          ),
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/icons/home.png',
                            color: Colors.white,
                            height: 45,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => widget.rightButton(),
                      child: Container(
                        height: 79,
                        width: widget.dialogSize.width / 2,
                        decoration: BoxDecoration(
                          color: widget.rightButtonColor,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/icons/gamepad.png',
                            color: Colors.white,
                            height: 45,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
