import 'package:flutter/material.dart';
import 'package:sudoku/classes/stat.dart';
import 'package:sudoku/colors.dart';
import 'package:sudoku/main.dart';
import 'package:sudoku/widgets/record_info.dart';

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

  Future<bool> getGameResults() async {
    gameResults = objectBox.gameDBController.getResultsByLevel();
    return true;
  }

  String formatTimer(int timer) {
    String m = '${timer ~/ 60}'.padLeft(2, '0');
    String s = '${timer % 60}'.padLeft(2, '0');
    return '$m:$s';
  }

  @override
  void initState() {
    stats = getGameResults();
    super.initState();
  }

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
            opacity: 0.5,
            fit: BoxFit.contain,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Container(
                    width: size.width,
                    height: 60,
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: SudokuColors.onahu,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: SudokuColors.onahu.withOpacity(0.8),
                              offset: const Offset(0, 4),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/icons/arrow2.png',
                            height: 17,
                            color: const Color(0xff3B95FF),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: size.width * 0.61,
                    height: 45,
                    decoration: BoxDecoration(
                      color: SudokuColors.onahu,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xff9FC6F3),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: SudokuColors.onahu.withOpacity(0.8),
                          offset: const Offset(0, 4),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Records',
                        style: TextStyle(
                          color: SudokuColors.dodgerBlueDarker,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  FutureBuilder(
                    future: stats,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: Text('Cargando datos'),
                        );
                      } else {
                        return SizedBox(
                          height: size.height - 290,
                          child: ListView(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                alignment: Alignment.centerLeft,
                                height: 40,
                                width: size.width,
                                decoration: BoxDecoration(
                                  color: SudokuColors.onahu.withOpacity(0.8),
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
                                label: 'Mejor Tiempo',
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
                                label: 'Mejor Tiempo',
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
                                label: 'Mejor Tiempo',
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
            ],
          ),
        ),
      ),
    );
  }
}
