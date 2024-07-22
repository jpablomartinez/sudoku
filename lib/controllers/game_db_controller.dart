import 'package:sudoku/classes/stat.dart';
import 'package:sudoku/database/model.dart';
import 'package:sudoku/objectbox.g.dart';
import 'package:sudoku/utils/game_state.dart';

class GameDBController {
  late final Box<SudokuStat> stats;

  List<Stat> getResultsByLevel() {
    const levels = ['easy', 'medium', 'hard'];
    List<Stat> statsResults = [];
    for (var level in levels) {
      Query<SudokuStat> queryWin = stats.query(SudokuStat_.level.equals(level).and(SudokuStat_.result.equals(winGame))).order(SudokuStat_.time, flags: Order.descending).build();
      Query<SudokuStat> queryMatches = stats.query(SudokuStat_.level.equals(level)).build();
      List<SudokuStat> matches = queryMatches.find();
      List<SudokuStat> wins = queryWin.find();
      statsResults.add(
        Stat(
          matches: matches.length,
          win: wins.length,
          gameOver: matches.length - wins.length,
          time: matches.isNotEmpty ? wins.last.time : 0,
        ),
      );
    }
    return statsResults;
  }

  void saveResult(SudokuStat stat) {
    stats.put(stat);
  }
}
