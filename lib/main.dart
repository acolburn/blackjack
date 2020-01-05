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
        Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            buildFaceDownCard(),
            Positioned(
              left: 30.0,
              child: buildCard(deck[random.nextInt(deck.length)]),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildCard(deck[random.nextInt(deck.length)]),
            buildCard(deck[random.nextInt(deck.length)]),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Material(
              elevation: 5,
              color: Colors.green,
              borderRadius: BorderRadius.circular(50),
              child: MaterialButton(
                onPressed: null,
                height: 90,
                minWidth: 90,
                child: Text(
                  'Hit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Material(
              elevation: 5,
              color: Colors.red,
              borderRadius: BorderRadius.circular(50),
              child: MaterialButton(
                onPressed: null,
                height: 90,
                minWidth: 90,
                child: Text(
                  'Stand',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Material(
              elevation: 5,
              color: Colors.blue,
              borderRadius: BorderRadius.circular(50),
              child: MaterialButton(
                onPressed: null,
                height: 90,
                minWidth: 90,
                child: Text(
                  'Double',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Material(
              elevation: 5,
              color: Colors.amber,
              borderRadius: BorderRadius.circular(50),
              child: MaterialButton(
                onPressed: null,
                height: 90,
                minWidth: 90,
                child: Text(
                  'Split',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    );

//    return Container();
  }
}
