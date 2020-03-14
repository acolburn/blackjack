import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'main.dart';
import 'dart:math';
import 'playing_card.dart';
import 'buttons.dart';
import 'splits.dart';
import 'soft_hands.dart';
import 'hard_hands.dart';
import 'flushbar.dart';
import 'package:blackjack/doubles.dart';
import 'info_cell.dart';
import 'error_screen.dart';
//import 'package:provider/provider.dart';
//import 'stopwatch.dart';

class MyHome extends StatefulWidget {
  final HandType handType;
  final bool isHighCount;
  MyHome(this.handType, this.isHighCount);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
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
  bool messageIsVisible =
      false; //whether or not you can see the message saying "Blackjack!", etc.
  String messageText = '';
  bool inclBlackjacks;

  AnimationController controller;
  Animation topFaceDownDealerCard;
  Animation topFaceUpDealerCard;
  Animation topPlayerCard1;
  Animation topPlayerCard2;
  Animation leftFaceDownDealerCard;
  Animation leftFaceUpDealerCard;
  Animation leftPlayerCard1;
  Animation leftPlayerCard2;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    topPlayerCard1 = Tween<double>(begin: 10, end: 270).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.30, curve: Curves.decelerate)));
    leftPlayerCard1 = Tween<double>(begin: 300, end: 140).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.30, curve: Curves.decelerate)));
    topPlayerCard2 = Tween<double>(begin: 10, end: 270).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.2, 0.5, curve: Curves.decelerate)));
    leftPlayerCard2 = Tween<double>(begin: 300, end: 220).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.2, 0.5, curve: Curves.decelerate)));
    topFaceDownDealerCard = Tween<double>(begin: 10, end: 60).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.40, 0.7, curve: Curves.decelerate)));
    leftFaceDownDealerCard = Tween<double>(begin: 300, end: 150).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.40, 0.7, curve: Curves.decelerate)));
    topFaceUpDealerCard = Tween<double>(begin: 10, end: 60).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.6, 1.0, curve: Curves.decelerate)));
    leftFaceUpDealerCard = Tween<double>(begin: 300, end: 180).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.6, 1.00, curve: Curves.decelerate)));

    controller.addListener(() {
      setState(() {});
    });
    dealHand(); //assign initial card values; without this, I get null value errors
    //when first Build() tries to assign values, etc. to cards that don't exist
    controller.forward();
  }

  void dealHand() {
    List<PlayingCard> deck = makeDeck();
//    deck.forEach((element) => print('${element.type} of ${element.suit}'));
    //Randomly pick two cards from deck
    playerCard1 = deck[random.nextInt(deck.length)];
    playerCard2 = deck[random.nextInt(deck.length)];

    //Exclude blackjacks?
    while ((inclBlackjacks == false) &&
        (cardValueToNumber(playerCard1) + cardValueToNumber(playerCard2) ==
            21)) {
      //Randomly pick two other cards from deck
      playerCard1 = deck[random.nextInt(deck.length)];
      playerCard2 = deck[random.nextInt(deck.length)];
    }

    //If you're limiting player hands to pairs only:
    if (widget.handType == HandType.pairs) {
      //Decrease how often a pair of tens or face cards come up
      if (cardValueToNumber(playerCard1) > 9) {
        playerCard1 = deck[random.nextInt(deck.length)];
      }
      playerCard2 = playerCard1;
    }

    //If you're limiting player hands to soft hands only:
    if (widget.handType == HandType.softHands) {
      playerCard2 = deck[0]; //deck[0] is an ace
      //Getting a lot of blackjacks; this decreases how often they appear
      if (cardValueToNumber(playerCard1) > 9) {
        playerCard1 = deck[random.nextInt(deck.length)];
      }
    }

    //Randomly pick dealer up card:
    dealerCard = deck[random.nextInt(deck.length)];

    // controller.forward();
  }

  Widget makeInfoTable() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //Display #correct and #incorrect
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            builder: (BuildContext context) => ErrorScreen(),
                          ),
                        );
                      }),
                  Row(
                    children: <Widget>[
                      Checkbox(
                        activeColor: Colors.white,
                        checkColor: Colors.green,
                        value: inclBlackjacks ?? true,
                        onChanged: (bool newValue) {
                          setState(() {
                            inclBlackjacks = newValue;
                          });
                        },
                      ),
                      Text('Include blackjacks?',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Verdana',
                              color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // dealHand();
    makeComputerDecision();

    //Build UI
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/blackjack_table.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              //Top Row
              Expanded(
                flex: 3,
                child: Stack(
                  children: <Widget>[
                    //Info table in top left corner
                    Align(
                      alignment: Alignment.topLeft,
                      child: makeInfoTable(),
                    ),
                    //Stopwatch in top right corner
                    // Align(
                    //   alignment: Alignment.topRight,
                    //   child: Consumer<StopWatchProvider>(
                    //     builder: (context, provider, child) {
                    //       return InkWell(
                    //         onTap: () {
                    //           provider.tapStopWatch();
                    //         },
                    //         child: Text(provider.stopwatchText,
                    //             style: TextStyle(
                    //                 fontSize: 32,
                    //                 fontFamily: 'Verdana',
                    //                 color: Colors.white)),
                    //       );
                    //     },
                    //   ),
                    // ),
                    //Player card 1
                    Positioned(
                      top: topPlayerCard1.value,
                      left: leftPlayerCard1.value,
                      child: buildCard(playerCard1),
                    ),
                    //Player card 2
                    Positioned(
                      top: topPlayerCard2.value,
                      left: leftPlayerCard2.value,
                      child: buildCard(playerCard2),
                    ),
                    //Dealer card (face down)
                    Positioned(
                      top: topFaceDownDealerCard.value,
                      left: leftFaceDownDealerCard.value,
                      child: buildFaceDownCard(),
                    ),
                    //Dealer card (face up)
                    Positioned(
                      top: topFaceUpDealerCard.value,
                      left: leftFaceUpDealerCard.value,
                      child: buildCard(dealerCard),
                    ),
                    //Message (will appear in center of Expanded(flex:2) screen area)
                    Visibility(
                      child: Center(
                        child: Text(messageText,
                            style:
                                TextStyle(fontSize: 32, color: Colors.black)),
                      ),
                      visible: messageIsVisible,
                    ),
                  ],
                ),
              ),
              //Player's decision buttons
              Expanded(
                flex: 1,
                child: Row(
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
              ),
              Expanded(
                flex: 1,
                child: Row(
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Build UI

  //           Expanded(
  //             flex: 6,
  //             child: Stack(
  //               overflow: Overflow.visible,
  //               children: <Widget>[],
  //             ),
  //           ),

  //       //Player's cards
  //       GestureDetector(
  //         behavior: HitTestBehavior
  //             .translucent, //entire screen [row areas] now recognized
  //         onTap: () {
  //           processPlayerDecision(context, Decision.hit);
  //         },
  //         onDoubleTap: () {
  //           processPlayerDecision(context, Decision.double);
  //         },
  //         onHorizontalDragEnd: (e) {
  //           processPlayerDecision(context, Decision.stand);
  //         },
  //         onScaleEnd: (end) {
  //           processPlayerDecision(context, Decision.split);
  //         },
  //         child: Stack(
  //           children: <Widget>[

  //           ],
  //         ),

  void makeComputerDecision() {
    handValue = computeHandValue(playerCard1, playerCard2);
    //If there's a blackjack.
    if (handValue == 21) {
      displayMessage('BLACKJACK!'); //this method will process the hand, too
      computerDecision = Decision.none;
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
    //Check for doubles. computerDecision may differ when count is high
    else if (handValue == 9 || handValue == 10 || handValue == 11) {
      computerDecision = checkForDoubles(
          playerCard1, playerCard2, dealerCard, widget.isHighCount);
    } else
    //It's your basic hard hand, totalling <=8 or 12-20. computerDecision may differ when count is high
    {
      computerDecision = processHardHand(
          playerCard1, playerCard2, dealerCard, widget.isHighCount);
    }
  }

  void displayMessage(String message) {
    messageIsVisible = true; //display the message
    messageText = message;
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        messageIsVisible = false; //2 seconds later, stop displaying the message
      });
    });
    computerDecision = Decision.none;
    processPlayerDecision(context, Decision.none);
  }

  void processPlayerDecision(BuildContext context, Decision playerDecision) {
    if (playerDecision == Decision.none) {
      //it's a blackjack, do nothing, just deal the next hand
    } else if (playerDecision != computerDecision) {
      incorrect++;
      percentCorrect = ((correct / (correct + incorrect)) * 100).round();
      displayFlushbar(context, playerDecision, computerDecision, playerCard1,
          playerCard2, dealerCard); //this method also adds error to error_chart
    } else
      correct++;

    percentCorrect = ((correct / (correct + incorrect)) * 100).round();
    setState(() {
      if (correct == 100 && incorrect == 0) {
        final player = AudioCache();
        player.play('tada.mp3');
        displayMessage('100 IN A ROW! WELL DONE!');
      }
      dealHand();
    });
    //Make the cards move
    controller.reset();
    controller.forward();
  }
}
