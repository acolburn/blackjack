import 'package:blackjack/doubles.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'playing_card.dart';
import 'buttons.dart';
import 'splits.dart';
import 'soft_hands.dart';
import 'hard_hands.dart';
import 'package:flushbar/flushbar.dart';

enum Decision { hit, stand, double, split, none }

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
  int handValue;
  Decision playerDecision = Decision.none;
  Decision computerDecision = Decision.none;

  void dealHand() {
    List<PlayingCard> deck = makeDeck();
    //    deck.forEach((element) => print('${element.type} of ${element.suit}'));
    playerCard1 = deck[random.nextInt(deck.length)];
    playerCard2 = deck[random.nextInt(deck.length)];
//    playerCard2 = playerCard1; //(for pair testing)
//    playerCard2 = deck[0]; //(for soft hand testing)
    dealerCard = deck[random.nextInt(deck.length)];
  }

  @override
  Widget build(BuildContext context) {
    dealHand();
    handValue = computeHandValue(playerCard1, playerCard2);
    //If there's a pair.
    if (playerCard1.value == playerCard2.value) {
      computerDecision = processSplit(playerCard1, playerCard2, dealerCard);
    } else
    //If there's an ace.
    if (playerCard1.value == CardValue.ace ||
        playerCard2.value == CardValue.ace) {
      computerDecision = processSoftHand(playerCard1, playerCard2, dealerCard);
    } else if (handValue == 9 || handValue == 10 || handValue == 11) {
      //Check for doubles
      computerDecision = checkForDoubles(playerCard1, playerCard2, dealerCard);
    } else {
      //It's your basic hard hand, totalling <=8 or 12-20
      computerDecision = processHardHand(playerCard1, playerCard2, dealerCard);
    }

//    print('Player should $computerDecision');

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
                  playerDecision = Decision.hit;
                  Flushbar(
                    title: (playerDecision == computerDecision).toString(),
                    message: "Player should $computerDecision",
                    duration: Duration(seconds: 1),
                  )..show(context);
                  setState(() {
                    dealHand();
                  });
                },
              ),
              MyButton(
                buttonText: 'Stand',
                buttonColor: Colors.red,
                onPress: () {
                  playerDecision = Decision.stand;
                  Flushbar(
                    title: (playerDecision == computerDecision).toString(),
                    message: "Player should $computerDecision",
                    duration: Duration(seconds: 1),
                  )..show(context);
                  setState(() {
                    dealHand();
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MyButton(
                buttonText: 'Double',
                buttonColor: Colors.blue,
                onPress: () {
                  playerDecision = Decision.double;
                  Flushbar(
                    title: (playerDecision == computerDecision).toString(),
                    message: "Player should $computerDecision",
                    duration: Duration(seconds: 1),
                  )..show(context);
                  setState(() {
                    dealHand();
                  });
                },
              ),
              MyButton(
                buttonText: 'Split',
                buttonColor: Colors.amber,
                onPress: () {
                  playerDecision = Decision.split;
                  Flushbar(
                    title: (playerDecision == computerDecision).toString(),
                    message: "Player should $computerDecision",
                    duration: Duration(seconds: 1),
                  )..show(context);
                  setState(() {
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
