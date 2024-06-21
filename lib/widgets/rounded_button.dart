import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color backgroundColor;
  final Widget icon;
  final Function onTap;
  final Size size;

  const RoundedButton({
    Key? key,
    this.backgroundColor = Colors.white,
    required this.icon,
    required this.onTap,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: size.width,
        height: size.height,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: icon,
        ),
      ),
    );
  }
}
