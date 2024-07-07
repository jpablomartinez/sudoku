import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  final Widget child;
  final String imgPath;
  const Layout({
    super.key,
    required this.imgPath,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg-blue.png'),
            opacity: 0.45,
            fit: BoxFit.contain,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: child,
        ),
      ),
    );
  }
}
