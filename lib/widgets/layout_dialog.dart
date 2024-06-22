import 'package:flutter/material.dart';

class LayoutGameAlertDialog extends StatefulWidget {
  final Widget widget;
  final Curve curve;
  final Color primaryColor;
  final Size size;

  const LayoutGameAlertDialog({
    super.key,
    required this.widget,
    required this.curve,
    required this.primaryColor,
    required this.size,
  });

  @override
  State<LayoutGameAlertDialog> createState() => _LayoutGameAlertDialogState();
}

class _LayoutGameAlertDialogState extends State<LayoutGameAlertDialog> with SingleTickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: animation,
          child: Container(
            height: widget.size.height,
            width: widget.size.width,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(color: widget.primaryColor, width: 2),
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(padding: const EdgeInsets.all(10), child: widget),
          ),
        ),
      ),
    );
  }
}
