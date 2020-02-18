import 'package:flutter/material.dart';
import 'dart:async';

class StopWatchProvider extends ChangeNotifier {
  String stopwatchText = ":00";
  final stopWatch = Stopwatch();
  final timeOneSec = Duration(seconds: 1);
//  String stopwatchStatus;

  //starts new Timer; after 1 sec (timeOneSec), _handleTimeout() will be called
  //nothing linked to UI, so no need to notifyListeners
  void startTimeout() {
    Timer(timeOneSec, handleTimeout);
  }

  void handleTimeout() {
    if (stopWatch.isRunning) {
      startTimeout();
    }
    //at each timeout (1 sec), update the stopwatch text
    setStopwatchText();
  }

  void tapStopWatch() {
    //if stopwatch is running, turn it off
    if (stopWatch.isRunning) {
      stopWatch.stop();
//      stopwatchStatus = 'stop';
    }
    //else if stopwatch is reset, start it
    else if (stopWatch.isRunning == false && stopWatch.elapsed.inSeconds == 0) {
      stopWatch.start();
//      stopwatchStatus = 'start';
      startTimeout();
    }
    //else if stopwatch is off, reset it
    else if (stopWatch.isRunning == false) {
      reset();
//      stopwatchStatus = 'reset';
    }

    notifyListeners();
  }

  void reset() {
    stopWatch.reset();
    setStopwatchText();
  }

  //need to notify stopwatch text to update its text
  void setStopwatchText() {
    //sets up actual stopwatch display text
    stopwatchText =
        ":" + (stopWatch.elapsed.inSeconds).toString().padLeft(2, "0");
    notifyListeners();
  }
}
