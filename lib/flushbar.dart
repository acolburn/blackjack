import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'main.dart';
import 'playing_card.dart';
import 'error_screen.dart';

String decisionToString(Decision d) {
  switch (d) {
    case (Decision.split):
      return 'SPLIT THE PAIR';
      break;
    case (Decision.double):
      return 'DOUBLE';
      break;
    case (Decision.hit):
      return 'HIT';
      break;
    case (Decision.stand):
      return 'STAND';
      break;
    default:
      return '...HMM, THERE\'S AN ERROR SOMEWHERE!';
      break;
  }
}

Flushbar displayFlushbar(
    BuildContext context,
    Decision playerDecision,
    Decision computerDecision,
    PlayingCard playerCard1,
    PlayingCard playerCard2,
    PlayingCard dealerCard) {
  String sCompDecision = decisionToString(computerDecision);
  String sPlayerDecision = decisionToString(playerDecision);
  String sCard1 = cardValueToString(playerCard1);
  String sCard2 = cardValueToString(playerCard2);
  String sCard3 = cardValueToString(dealerCard);

  addRow('($sCard1, $sCard2) vs $sCard3', sPlayerDecision, sCompDecision);
  return Flushbar(
    title: '$sCompDecision',
    messageText: Text(
      "$sCompDecision with ($sCard1, $sCard2) against $sCard3",
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
