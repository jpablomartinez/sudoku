import 'package:objectbox/objectbox.dart';
import 'package:sudoku/classes/stat.dart';
import 'package:sudoku/database/model.dart';
import 'package:sudoku/objectbox.g.dart';

class GameDBController {
  late final Box<SudokuStat> stats;

  List<SudokuStat> findAllByLevel(String level) {
    List<SudokuStat> all = stats.getAll();
    return all.where((s) => s.level == level).toList();
  }

  Stat findResultsByLevel(String level) {
    /*
    QueryBuilder<Location> qb = locationBox.query(Location_.locationKey.equals(locationKey));
    Query q = qb.build();
    Location? location = q.findUnique();
    q.close();
    return location!;
    */
    Query<SudokuStat> queryWin = stats.query(SudokuStat_.level.equals(level).and(SudokuStat_.result.equals(1))).build();
    Query<SudokuStat> queryMatches = stats.query(SudokuStat_.level.equals(level).and(SudokuStat_.result.equals(0))).order(SudokuStat_.time, flags: Order.descending).build();
    List<SudokuStat> matches = queryMatches.find();
    int win = queryWin.find().length;
    int gameOver = matches.length - win;
    int betterTime = matches.last.time;

    return Stat(
      matches: matches.length,
      win: win,
      gameOver: gameOver,
      time: betterTime,
    );
  }
}
