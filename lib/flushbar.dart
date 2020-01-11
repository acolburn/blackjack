import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'main.dart';

Flushbar displayFlushbar(BuildContext context, Decision computerDecision) {
  String s;
  switch (computerDecision) {
    case (Decision.split):
      s = 'SPLIT THE PAIR';
      break;
    case (Decision.double):
      s = 'DOUBLE';
      break;
    case (Decision.hit):
      s = 'HIT';
      break;
    case (Decision.stand):
      s = 'STAND';
      break;
    default:
      s = '...HMM, THERE\'S AN ERROR SOMEWHERE!';
      break;
  }
  return Flushbar(
    title: 'INCORRECT',
    messageText: Text(
      "Player should $s",
      style: TextStyle(fontSize: 20, color: Colors.white),
    ),
    icon: Icon(
      Icons.error,
      size: 32,
      color: Colors.blueAccent,
    ),
    leftBarIndicatorColor: Colors.blueAccent,
    duration: Duration(milliseconds: 2000),
  )..show(context);
}
