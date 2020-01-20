import 'package:blackjack/doubles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'playing_card.dart';
import 'buttons.dart';
import 'splits.dart';
import 'soft_hands.dart';
import 'hard_hands.dart';
import 'flushbar.dart';
import 'error_screen.dart';
import 'info_cell.dart';

enum Decision { hit, stand, double, split, none }

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Must use app in portrait mode
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blackjack Trainer',
      home: MyHome(),
      routes: <String, WidgetBuilder>{
        '/error_screen': (BuildContext context) => ErrorScreen(),
      },
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
  int correct = 0;
  int incorrect = 0;
  int percentCorrect = 0;
  bool messageIsVisible = false; //text message overlay's visibility
  String messageText = '';

  void dealHand() {
    List<PlayingCard> deck = makeDeck();
//    deck.forEach((element) => print('${element.type} of ${element.suit}'));
    playerCard1 = deck[random.nextInt(deck.length)];
    playerCard2 = deck[random.nextInt(deck.length)];
    // playerCard2 = playerCard1; //(for pair testing)
//    playerCard2 = deck[0]; //(for soft hand testing)
    dealerCard = deck[random.nextInt(deck.length)];
  }

  @override
  Widget build(BuildContext context) {
    dealHand();
    makeComputerDecision();

    //Build UI

    return Scaffold(
      backgroundColor: Colors.green[500],
      body: GestureDetector(
        behavior: HitTestBehavior.translucent, //entire screen now recognized
        onTap: () {
          processPlayerDecision(context, Decision.hit);
        },
        onDoubleTap: () {
          processPlayerDecision(context, Decision.double);
        },
        onHorizontalDragEnd: (e) {
          processPlayerDecision(context, Decision.stand);
        },
        onScaleEnd: (end) {
          processPlayerDecision(context, Decision.split);
        },

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                //Display #correct and #incorrect
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    children: <Widget>[
                      makeInfoCell('Correct: $correct'),
                      makeInfoCell('Incorrect: $incorrect'),
                      makeInfoCell('$percentCorrect% correct'),
                      makeInfoCellButton(
                          name: 'Reset',
                          action: () {
                            setState(() {
                              correct = 0;
                              incorrect = 0;
                              percentCorrect = 100;
                              rowList = [];
                            });
                          }),
                      makeInfoCellButton(
                          name: 'Errors',
                          action: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ErrorScreen(),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
                Expanded(flex: 1, child: Container()),
                //Dealer's cards
                Expanded(
                  flex: 4,
                  child: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      buildFaceDownCard(),
                      Positioned(
                        left: 30.0,
                        child: buildCard(dealerCard),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            //Player's cards
            Stack(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buildCard(playerCard1),
                    buildCard(playerCard2),
                  ],
                ),
                Visibility(
                  child: Center(
                    child: Text(messageText,
                        style: TextStyle(fontSize: 32, color: Colors.black)),
                  ),
                  visible: messageIsVisible,
                ),
              ],
            ),
            //Player's decision buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                PlayButton(
                  buttonText: 'Hit',
                  buttonColor: Colors.green[600],
                  onPress: () {
                    processPlayerDecision(context, Decision.hit);
                  },
                ),
                PlayButton(
                  buttonText: 'Stand',
                  buttonColor: Colors.red,
                  onPress: () {
                    processPlayerDecision(context, Decision.stand);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                PlayButton(
                  buttonText: 'Double',
                  buttonColor: Colors.blue,
                  onPress: () {
                    processPlayerDecision(context, Decision.double);
                  },
                ),
                PlayButton(
                  buttonText: 'Split',
                  buttonColor: Colors.amber,
                  onPress: () {
                    processPlayerDecision(context, Decision.split);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void makeComputerDecision() {
    handValue = computeHandValue(playerCard1, playerCard2);
    //If there's a blackjack.
    if (handValue == 21) {
      displayMessage('Blackjack!');
    }
    //If there's a pair.
    else if (playerCard1.value == playerCard2.value) {
      computerDecision = processSplit(playerCard1, playerCard2, dealerCard);
    }
    //If there's an ace.
    else if (playerCard1.value == CardValue.ace ||
        playerCard2.value == CardValue.ace) {
      computerDecision = processSoftHand(playerCard1, playerCard2, dealerCard);
    }
    //Check for doubles
    else if (handValue == 9 || handValue == 10 || handValue == 11) {
      computerDecision = checkForDoubles(playerCard1, playerCard2, dealerCard);
    } else
    //It's your basic hard hand, totalling <=8 or 12-20
    {
      computerDecision = processHardHand(playerCard1, playerCard2, dealerCard);
    }
  }

  void displayMessage(String message) {
    messageIsVisible = true;
    messageText = message;
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        messageIsVisible = false;
        dealHand();
      });
    });
  }

  void processPlayerDecision(BuildContext context, Decision playerDecision) {
    if (playerDecision != computerDecision) {
      incorrect++;
      percentCorrect = ((correct / (correct + incorrect)) * 100).round();
      displayFlushbar(context, playerDecision, computerDecision, playerCard1,
          playerCard2, dealerCard);
    } else
      correct++;
    percentCorrect = ((correct / (correct + incorrect)) * 100).round();
    setState(() {
      (correct == 100 && incorrect == 0)
          ? displayMessage('100/100! Well done!')
          : dealHand();
    });
  }
}
