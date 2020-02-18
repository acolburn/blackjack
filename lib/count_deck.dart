import 'package:flutter/material.dart';
import 'dart:async';
import 'playing_card.dart';
import 'info_cell.dart';
import 'package:provider/provider.dart';
import 'stopwatch.dart';

class CountDeck extends StatefulWidget {
  @override
  _CountDeckState createState() => _CountDeckState();
}

class _CountDeckState extends State<CountDeck> {
  int i = 0;
  int count = 0;
  bool isCountVisible = true;
  bool isMultiCard = false;
  List<PlayingCard> deck = makeDeck();

  @override
  void initState() {
    super.initState();
    deck.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StopWatchProvider>(
      create: (context) => StopWatchProvider(),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/blackjack_table.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
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
                            isCountVisible = !isCountVisible;
                          });
                        }),
                    makeInfoCellButton(
                        name: 'Auto',
                        action: () {
                          resetDeck();
                          Timer.periodic(Duration(seconds: 1), (timer) {
                            print('$i');
                            if (i < 51) {
                              i++;

                              setState(() {
                                countCard(deck[i]);
                              });
                            } else
                              timer.cancel();
                          });
                        }),
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
//            Expanded(flex: 1, child: Container()),
              GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        buildCard(getNextCard()) ?? buildFaceDownCard(),
                        Visibility(
                          visible: isMultiCard,
                          child: (isMultiCard == true)
                              ? buildCard(getNextCard())
                              : buildFaceDownCard(),
                        ),
                      ],
                    ),
                    Visibility(
                        visible: isCountVisible,
                        child: Text('$count',
                            style:
                                TextStyle(fontSize: 42, color: Colors.black)))
                  ],
                ),
              ),
              //Expanded() widgets help place card location on screen
              Expanded(flex: 2, child: Container()),
              Consumer<StopWatchProvider>(
                builder: (context, provider, child) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                    child: InkWell(
                      onTap: () {
                        provider.tapStopWatch();
                      },
                      child: Text(provider.stopwatchText,
                          style: TextStyle(
                              fontSize: 42,
                              fontFamily: 'Verdana',
                              color: Colors.white)),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void resetDeck() {
    deck.shuffle();
    setState(() {
      count = 0;
      i = 0;
    });
  }

  void countCard(PlayingCard aCard) {
    if (cardValueToNumber(aCard) >= 10) {
      count--;
    } else if (cardValueToNumber(aCard) <= 7) {
      count++;
    }
  }

  PlayingCard getNextCard() {
    if (i <= 51) {
      countCard(deck[i]);
      i++;
      return deck[i - 1];
    }
    return null;
  }
}
