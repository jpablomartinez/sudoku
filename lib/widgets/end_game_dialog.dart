import 'package:flutter/material.dart';
import 'package:sudoku/colors.dart';
import 'package:sudoku/widgets/star.dart';

class EndgameDialog extends StatefulWidget {
  final String title;
  final String time;
  final String imgPath;
  final int points;
  final Color primaryColor;
  final Color secondaryColor;
  final Size imgSize;
  final Size dialogSize;
  final Curve curve;
  final Function leftButton;
  final Function rightButton;
  final int maxPoints;

  const EndgameDialog({
    super.key,
    required this.title,
    required this.time,
    required this.imgPath,
    required this.points,
    required this.primaryColor,
    required this.secondaryColor,
    required this.imgSize,
    required this.dialogSize,
    required this.curve,
    required this.leftButton,
    required this.rightButton,
    required this.maxPoints,
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
    for (int i = widget.maxPoints; i > 0; i--) {
      if (i > widget.points) {
        stars.add(const StarWidget(
          isFull: false,
          height: 30,
        ));
      } else {
        stars.add(const StarWidget(
          isFull: true,
          height: 30,
        ));
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              //border: Border.all(color: widget.primaryColor, width: 2),
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: widget.primaryColor,
                      fontSize: 34,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  getStars(),
                  const SizedBox(height: 15),
                  Image.asset(
                    widget.imgPath,
                    height: widget.imgSize.height,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Tiempo usado: ${widget.time}',
                    style: TextStyle(
                      color: widget.primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () => widget.leftButton(),
                            child: Container(
                              height: 52,
                              width: 52,
                              decoration: BoxDecoration(
                                color: widget.secondaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/icons/home.png',
                                  width: 22,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          const Text(
                            'Menú',
                            style: TextStyle(
                              color: SudokuColors.congressBlue,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () => widget.rightButton(),
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: widget.secondaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/icons/game-icon.png',
                                  width: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          const Text(
                            'Jugar',
                            style: TextStyle(
                              color: SudokuColors.congressBlue,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
