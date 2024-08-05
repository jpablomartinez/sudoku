import 'package:flutter/material.dart';
import 'package:sudoku/screens/title.dart';
import 'package:sudoku/widgets/fade_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> changePage() async {
    Future.delayed(const Duration(milliseconds: 2000), () async {
      Navigator.pushReplacement(
        context,
        FadeRoute(
          page: const MainMenu(),
          duration: 600,
        ),
        //ModalRoute.withName('/'),
      );
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      changePage();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/splash.png'),
          fit: BoxFit.contain,
        ),
      ),
    ));
  }
}
