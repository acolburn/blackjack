import 'package:flutter/material.dart';
import 'dart:math';
import 'playing_card.dart';
import 'buttons.dart';
import 'splits.dart';

enum Decision { hit, stand, double, split }

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

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final random = Random();

  PlayingCard playerCard1;
  PlayingCard playerCard2;
  PlayingCard dealerCard;
  Decision playerDecision;
  Decision computerDecision;

  void dealHand() {
    List<PlayingCard> deck = makeDeck();
    //    deck.forEach((element) => print('${element.type} of ${element.suit}'));
    playerCard1 = deck[random.nextInt(deck.length)];
    playerCard2 = deck[random.nextInt(deck.length)];
//    PlayingCard playerCard2 = playerCard1; (for pair testing)
    dealerCard = deck[random.nextInt(deck.length)];
  }

  @override
  Widget build(BuildContext context) {
    dealHand();
    //Pair?
    if (playerCard1.value == playerCard2.value) {
      if (testForSplit(playerCard1, playerCard2, dealerCard)) {
        computerDecision = Decision.split;
      }
    }
    //Ace?
    //Double?
    //Must be hard hand

    //Build UI
    return GestureDetector(
      behavior: HitTestBehavior.translucent, //entire screen now recognized
      onTap: () {
        setState(() {
          dealHand();
        });
      },
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
                onPress: () {
                  setState(() {
                    print('Hit');
                    dealHand();
                  });
                },
              ),
              MyButton(
                buttonText: 'Stand',
                buttonColor: Colors.red,
                onPress: () {
                  setState(() {
                    print('Stand');
                    dealHand();
                  });
                },
              ),
              MyButton(
                buttonText: 'Double',
                buttonColor: Colors.blue,
                onPress: () {
                  setState(() {
                    print('Double');
                    dealHand();
                  });
                },
              ),
              MyButton(
                buttonText: 'Split',
                buttonColor: Colors.amber,
                onPress: () {
                  setState(() {
                    print('Split');
                    dealHand();
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
