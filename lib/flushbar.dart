import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'main.dart';
import 'playing_card.dart';

Flushbar displayFlushbar(BuildContext context, Decision computerDecision,
    PlayingCard playerCard1, PlayingCard playerCard2, PlayingCard dealerCard) {
  String s;
  String sCard1 = cardValueToString(playerCard1);
  String sCard2 = cardValueToString(playerCard2);
  String sCard3 = cardValueToString(dealerCard);
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
    title: '$s',
    messageText: Text(
      "$s with ($sCard1, $sCard2) against $sCard3",
      style: TextStyle(fontSize: 18, color: Colors.white),
    ),
    icon: Icon(
      Icons.error,
      size: 32,
      color: Colors.blueAccent,
    ),
    leftBarIndicatorColor: Colors.blueAccent,
    duration: Duration(milliseconds: 2500),
  )..show(context);
}
