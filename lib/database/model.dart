import 'package:objectbox/objectbox.dart';

@Entity()
class SudokuStat {
  int id; //unique identifier
  int time; //seconds use in game
  String level; //easy, medium, hard
  int result; //0 gameover, 1 win

  SudokuStat({
    this.id = 0,
    required this.time,
    required this.level,
    required this.result,
  });
}
