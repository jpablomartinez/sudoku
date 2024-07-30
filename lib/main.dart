import 'package:flutter/material.dart';
import 'package:sudoku/controllers/database_controller.dart';
import 'package:sudoku/screens/title.dart';

late ObjectBox objectBox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.init();
  print('box ready');
  runApp(const SudokuGameView());
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
      home: const MainMenu(),
    );
  }
}
