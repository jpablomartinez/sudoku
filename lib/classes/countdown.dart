import 'dart:async';

class Countdown {
  late Timer timerController;
  int duration = 0;
  int remaining = 0;
  int time = 0;
  bool start = false;

  Countdown(int d) {
    duration = d;
  }

  startCountdown(Duration dur, Function callback) {
    start = true;
    timerController = Timer.periodic(dur, (timer) {
      remaining = duration--;
      callback();
    });
  }

  startTimer(Duration dur, Function callback) {
    start = true;
    timerController = Timer.periodic(dur, (timer) {
      time++;
      callback();
    });
  }

  void pause() {
    timerController.cancel();
  }

  void play() {
    startCountdown(Duration(seconds: remaining), () {});
  }
}
