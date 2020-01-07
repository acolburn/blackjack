import 'package:flutter/material.dart';
import 'dart:math';
import 'playing_card.dart';
import 'buttons.dart';
import 'splits.dart';

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
  final random = Random();

  @override
  Widget build(BuildContext context) {
    List<PlayingCard> deck = makeDeck();
    PlayingCard playerCard1 = deck[random.nextInt(deck.length)];
    PlayingCard playerCard2 = deck[random.nextInt(deck.length)];
//    PlayingCard playerCard2 = playerCard1; (pair testing)
    PlayingCard dealerCard = deck[random.nextInt(deck.length)];
    print(testForSplit(playerCard1, playerCard2, dealerCard));
//    deck.forEach((element) => print('${element.type} of ${element.suit}'));
    return GestureDetector(
      behavior: HitTestBehavior.translucent, //entire screen now recognized
      onTap: () => print('Hit'),
      onDoubleTap: () => print('Double'),
      onHorizontalDragEnd: (e) => print('Stand'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          //Dealer's cards
          Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              buildFaceDownCard(),
              Positioned(
                left: 30.0,
                child: buildCard(dealerCard),
              ),
            ],
          ),
          //Player's cards
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildCard(playerCard1),
              buildCard(playerCard2),
            ],
          ),
          //Player's decision buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MyButton(
                buttonText: 'Hit',
                buttonColor: Colors.green,
                onPress: () => print('Hit'),
              ),
              MyButton(
                buttonText: 'Stand',
                buttonColor: Colors.red,
                onPress: () => print('Stand'),
              ),
              MyButton(
                buttonText: 'Double',
                buttonColor: Colors.blue,
                onPress: () => print('Double'),
              ),
              MyButton(
                buttonText: 'Split',
                buttonColor: Colors.amber,
                onPress: () => print('Split'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
