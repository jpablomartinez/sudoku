import 'package:flutter/material.dart';
import 'package:sudoku/classes/stat.dart';
import 'package:sudoku/colors.dart';
import 'package:sudoku/main.dart';
import 'package:sudoku/utils/time_mode.dart';
import 'package:sudoku/widgets/arrow_back.dart';
import 'package:sudoku/widgets/record_info.dart';
import 'package:sudoku/widgets/responsive_screen.dart';
import 'package:sudoku/widgets/title_screen.dart';

//TODO: IMPROVE THIS CODE
class RecordsView extends StatefulWidget {
  const RecordsView({
    super.key,
  });

  @override
  State<RecordsView> createState() => _RecordsViewState();
}

class _RecordsViewState extends State<RecordsView> {
  late Future<bool> stats;
  List<Stat> gameResults = [];
  var category = SudokuTimeMode.timer;

  Future<bool> getGameResults(int timeMode) async {
    gameResults = objectBox.gameDBController.getResultsByLevel(timeMode);
    return true;
  }

  String formatTimer(int timer) {
    String m = '${timer ~/ 60}'.padLeft(2, '0');
    String s = '${timer % 60}'.padLeft(2, '0');
    return '$m:$s';
  }

  void changeCategory(SudokuTimeMode timeMode) {
    stats = getGameResults(timeMode == SudokuTimeMode.timer ? 1 : 2);
    setState(() {
      category = timeMode;
    });
  }

  @override
  void initState() {
    stats = getGameResults(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          //height: size.height,
          //width: size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg-blue.png'),
              opacity: 0.5,
              fit: BoxFit.contain,
            ),
          ),
          child: ResponsiveScreen(
            squarishMainArea: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ArrowBack(onTap: () => Navigator.pop(context)),
                    const TitleScreen(title: 'Records'),
                    const SizedBox(),
                  ],
                ),
                const SizedBox(height: 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () => changeCategory(SudokuTimeMode.timer),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: category == SudokuTimeMode.timer ? const Color(0xff3B95FF) : Colors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Hay tiempo',
                            style: TextStyle(
                              color: category == SudokuTimeMode.timer ? const Color(0xff3B95FF) : const Color.fromARGB(255, 1, 20, 43),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => changeCategory(SudokuTimeMode.countdown),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: category == SudokuTimeMode.countdown ? const Color(0xff3B95FF) : Colors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Contrareloj',
                            style: TextStyle(
                              color: category == SudokuTimeMode.countdown ? const Color(0xff3B95FF) : const Color.fromARGB(255, 1, 20, 43),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                FutureBuilder(
                  future: stats,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: Text('Cargando datos'),
                      );
                    } else {
                      return Expanded(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              alignment: Alignment.centerLeft,
                              height: 40,
                              width: size.width,
                              decoration: BoxDecoration(
                                color: SudokuColors.onahu.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                'Principiante',
                                style: TextStyle(
                                  color: Color(0xff3B95FF),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RecordInfo(
                              icon: 'assets/icons/gameboy.png',
                              label: 'Juegos',
                              amount: '${gameResults[0].matches}',
                              chipColor: const Color(0xff4D7AD0),
                              size: size,
                            ),
                            RecordInfo(
                              icon: 'assets/icons/trophy.png',
                              label: 'Victorias',
                              amount: '${gameResults[0].win}',
                              chipColor: const Color(0xff4DD089),
                              size: size,
                            ),
                            RecordInfo(
                              icon: 'assets/icons/game-over2.png',
                              label: 'Derrotas',
                              amount: '${gameResults[0].gameOver}',
                              chipColor: const Color(0xffFA604B),
                              size: size,
                            ),
                            RecordInfo(
                              icon: 'assets/icons/timer.png',
                              label: 'Tiempo al ganar',
                              amount: formatTimer(gameResults[0].time ?? 0),
                              chipColor: const Color(0xff834BFA),
                              size: size,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              alignment: Alignment.centerLeft,
                              height: 40,
                              width: size.width,
                              decoration: BoxDecoration(
                                color: SudokuColors.onahu.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                'Intermedio',
                                style: TextStyle(
                                  color: Color(0xff3B95FF),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RecordInfo(
                              icon: 'assets/icons/gameboy.png',
                              label: 'Juegos',
                              amount: '${gameResults[1].matches}',
                              chipColor: const Color(0xff4D7AD0),
                              size: size,
                            ),
                            RecordInfo(
                              icon: 'assets/icons/trophy.png',
                              label: 'Victorias',
                              amount: '${gameResults[1].win}',
                              chipColor: const Color(0xff4DD089),
                              size: size,
                            ),
                            RecordInfo(
                              icon: 'assets/icons/game-over2.png',
                              label: 'Derrotas',
                              amount: '${gameResults[1].gameOver}',
                              chipColor: const Color(0xffFA604B),
                              size: size,
                            ),
                            RecordInfo(
                              icon: 'assets/icons/timer.png',
                              label: 'Tiempo al ganar',
                              amount: formatTimer(gameResults[1].time ?? 0),
                              chipColor: const Color(0xff834BFA),
                              size: size,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              alignment: Alignment.centerLeft,
                              height: 40,
                              width: size.width,
                              decoration: BoxDecoration(
                                color: SudokuColors.onahu.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                'Experto',
                                style: TextStyle(
                                  color: Color(0xff3B95FF),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RecordInfo(
                              icon: 'assets/icons/gameboy.png',
                              label: 'Juegos',
                              amount: '${gameResults[2].matches}',
                              chipColor: const Color(0xff4D7AD0),
                              size: size,
                            ),
                            RecordInfo(
                              icon: 'assets/icons/trophy.png',
                              label: 'Victorias',
                              amount: '${gameResults[2].win}',
                              chipColor: const Color(0xff4DD089),
                              size: size,
                            ),
                            RecordInfo(
                              icon: 'assets/icons/game-over2.png',
                              label: 'Derrotas',
                              amount: '${gameResults[2].gameOver}',
                              chipColor: const Color(0xffFA604B),
                              size: size,
                            ),
                            RecordInfo(
                              icon: 'assets/icons/timer.png',
                              label: 'Tiempo al ganar',
                              amount: formatTimer(gameResults[2].time ?? 0),
                              chipColor: const Color(0xff834BFA),
                              size: size,
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            rectangularMenuArea: const SizedBox(),
          )),
    );
  }
}
