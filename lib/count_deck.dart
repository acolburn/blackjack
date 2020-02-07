import 'package:flutter/material.dart';
import 'dart:async';
import 'playing_card.dart';
import 'info_cell.dart';

class CountDeck extends StatefulWidget {
  @override
  _CountDeckState createState() => _CountDeckState();
}

class _CountDeckState extends State<CountDeck> {
  int i = 0;
  int count = 0;
  bool isVisible = true;
  bool isMultiCard = true;
  List<PlayingCard> deck = makeDeck();

  @override
  void initState() {
    super.initState();
    deck.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/blackjack_table.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
//          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                children: <Widget>[
                  makeInfoCellButton(
                    name: 'Reset Deck',
                    action: resetDeck,
                  ),
                  makeInfoCellButton(
                      name: 'Display Count',
                      action: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      }),
                  makeInfoCellButton(
                    name: 'Auto',
                    action: autoCountdown,
                  ),
                  Row(
                    children: <Widget>[
                      Checkbox(
                        activeColor: Colors.white,
                        checkColor: Colors.green,
                        value: isMultiCard ?? true,
                        onChanged: (bool newValue) {
                          setState(() {
                            isMultiCard = newValue;
                          });
                        },
                      ),
                      Text('Show 2+ cards?',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Verdana',
                              color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
            //Expanded() widgets help place card location on screen
            //adds space between buttons (on left) & card/count (in middle)
            Expanded(flex: 1, child: Container()),
            GestureDetector(
              onTap: () {
                if (i < 51 && isMultiCard == false) {
                  dealCards(1);
                } else if (i < 49 && isMultiCard == true) {
                  dealCards(3);
                } else if (i < 51 && isMultiCard == true) {
                  dealCards(1);
                } else {
                  dealCards(0);
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: displayMultipleCards(),
                  ),
                  Visibility(
                    visible: isVisible,
                    child: Text('$count',
                        style: TextStyle(fontSize: 42, color: Colors.black)),
                  ),
                ],
              ),
            ),

            //Expanded() widgets help place card location on screen
            //adds space between card/count (in middle) & space (right)
            Expanded(flex: 2, child: Container())
          ],
        ),
      ),
    );
  }

  void dealCards(int n) {
    setState(() {
      i = i + n;
      if (n == 1) {
        adjustCount(deck[i]);
      } else if (n == 2) {
        adjustCount(deck[i]);
        adjustCount(deck[i + 1]);
      } else if (n == 3) {
        adjustCount(deck[i]);
        adjustCount(deck[i + 1]);
        adjustCount(deck[i + 2]);
      } else {
        return;
      }
    });
  }

  void adjustCount(PlayingCard aCard) {
    if (cardValueToNumber(aCard) >= 10) {
      count--;
    } else if (cardValueToNumber(aCard) <= 7) {
      count++;
    }
  }

  void resetDeck() {
    deck.shuffle();
    if (isMultiCard == false) {
      setState(() {
        i = 0;
        count = 0;
        adjustCount(deck[0]);
      });
    } else if (isMultiCard == true) {
      setState(() {
        count = 0;
        i = 0;
        adjustCount(deck[0]);
        adjustCount(deck[1]);
        adjustCount(deck[2]);
      });
    }
  }

  void autoCountdown() {
    resetDeck();
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (i < 51) {
        i++;
        adjustCount(deck[i]);
        setState(() {});
      } else
        timer.cancel();
    });
  }

  List<Widget> displayMultipleCards() {
    if (isMultiCard == false) {
      return <Widget>[
        buildCard(deck[i]),
      ];
    } else if (i < 49 && isMultiCard == true) {
      return <Widget>[
        buildCard(deck[i]),
        buildCard(deck[i + 1]),
        buildCard(deck[i + 2]),
      ];
    } else {
      return <Widget>[
        buildCard(deck[i]),
      ];
    }
  }
}
