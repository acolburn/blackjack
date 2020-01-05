import 'package:flutter/material.dart';
import 'dart:math';
import 'playing_card.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blackjack Trainer',
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  var random = Random();
  @override
  Widget build(BuildContext context) {
    List<PlayingCard> deck = makeDeck();
//    deck.forEach((element) => print('${element.type} of ${element.suit}'));
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildFaceDownCard(),
            buildCard(deck[random.nextInt(deck.length + 1)]),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildCard(deck[random.nextInt(deck.length + 1)]),
            buildCard(deck[random.nextInt(deck.length + 1)]),
          ],
        ),
      ],
    );

//    return Container();
  }
}
