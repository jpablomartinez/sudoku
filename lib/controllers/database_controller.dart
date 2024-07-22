import 'package:sudoku/controllers/game_db_controller.dart';
import 'package:sudoku/database/model.dart';
import 'package:sudoku/objectbox.g.dart';

class ObjectBox {
  late final Store _store;
  GameDBController gameDBController = GameDBController();

  ObjectBox._init(this._store) {
    gameDBController.stats = Box<SudokuStat>(_store);
  }

  static Future<ObjectBox> init() async {
    final store = await openStore();
    return ObjectBox._init(store);
  }
}
