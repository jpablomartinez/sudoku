import 'dart:async';

class Countdown {
  late Timer timerController;
  int duration = 0;
  int remaining = 0;
  bool start = false;

  Countdown(int d) {
    duration = d;
  }

  startCountdown(Duration dur, Function callback) {
    start = true;
    timerController = Timer.periodic(const Duration(seconds: 1), (timer) {
      remaining = duration--;
      print(remaining);
    });
  }

  void pause() {
    timerController.cancel();
  }

  void play() {
    startCountdown(Duration(seconds: remaining), () {});
  }
}
