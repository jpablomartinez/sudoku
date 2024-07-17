import 'package:sudoku/objectbox.g.dart';

class ObjectBox {
  late final Store _store;

  ObjectBox._init(this._store) {
    //locationController.locationBox = Box<Location>(_store);
  }

  static Future<ObjectBox> init() async {
    final store = await openStore();
    return ObjectBox._init(store);
  }
}
