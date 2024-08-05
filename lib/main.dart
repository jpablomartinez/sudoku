import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sudoku/controllers/database_controller.dart';
import 'package:sudoku/screens/splash.dart';

late ObjectBox objectBox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const SudokuGameView());
  });
}

class SudokuGameView extends StatelessWidget {
  const SudokuGameView({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sudoku',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Gluten',
      ),
      home: const SplashScreen(),
      initialRoute: '/',
    );
  }
}
