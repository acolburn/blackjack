import 'package:flutter/material.dart';
import 'dart:async';
import 'playing_card.dart';
import 'info_cell.dart';
import 'package:provider/provider.dart';

class Data extends ChangeNotifier {
  int i = 0;
  int count = 0;
  bool countIsVisible = true;
  bool isMultiCard = false;
  List<PlayingCard> deck = makeDeck();

  PlayingCard currentCard() {
    return deck[i];
  }

  bool isEndOfDeck() {
    if (i == 51) {
      return true;
    } else {
      return false;
    }
  }

  void changeCountVisibility() {
    countIsVisible = !countIsVisible;
    notifyListeners();
  }

  void changeIsMulticard(bool value) {
    isMultiCard = value;
    notifyListeners();
  }

  void resetDeck() {
    deck.shuffle();

    i = 0;
    if (cardValueToNumber(deck[0]) >= 10) {
      count = -1;
    } else if (cardValueToNumber(deck[0]) <= 7) {
      count = 1;
    } else {
      count = 0;
    }
    notifyListeners();
  }

  void adjustCount(PlayingCard aCard) {
    if (cardValueToNumber(aCard) >= 10) {
      count--;
    } else if (cardValueToNumber(aCard) <= 7) {
      count++;
    }
    notifyListeners();
  }

  bool countNextCard() {
    bool result = true;
    if (i < 51) {
      i++;
      adjustCount(deck[i]);
    } else {
      result = false;
    }
    notifyListeners();
    return result;
  }
}

class CountDeck extends StatefulWidget {
  @override
  _CountDeckState createState() => _CountDeckState();
}

class _CountDeckState extends State<CountDeck> {
//  int i = 0;
//  int count = 0;
//  bool isVisible = true;
//  bool isMultiCard = false;
//  List<PlayingCard> deck = makeDeck();

  @override
  void initState() {
    super.initState();
//    Provider.of<Data>(context).deck.shuffle();
  }

  @override
  Widget build(BuildContext context) {
//    final providerOfData = Provider.of<Data>(context);

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
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  makeInfoCellButton(
                    name: 'Reset Deck',
                    action: Provider.of<Data>(context).resetDeck,
                  ),
                  makeInfoCellButton(
                      name: 'Display Count',
                      action: () {
                        setState(() {
                          Provider.of<Data>(context).changeCountVisibility();
                        });
                      }),
                  makeInfoCellButton(
                    name: 'Auto',
                    action: () {
                      Provider.of<Data>(context).resetDeck();
                      Timer.periodic(
                        Duration(seconds: 1),
                        (timer) {
                          //while there's still cards in the deck
                          while (Provider.of<Data>(context).isEndOfDeck() ==
                              false) {
                            //get the next card, adjust the count, display the card
                            Provider.of<Data>(context).countNextCard();
                          }
                          //when there's no cards in the deck
                          //stop the timer
                          timer.cancel();
                        },
                      );
                    },
                  ),
                  Row(
                    children: <Widget>[
                      Checkbox(
                        activeColor: Colors.white,
                        checkColor: Colors.green,
                        value: Provider.of<Data>(context).isMultiCard ?? true,
                        onChanged: (bool newValue) {
                          setState(() {
                            Provider.of<Data>(context)
                                .changeIsMulticard(newValue);
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
                Provider.of<Data>(context).countNextCard();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildCard(Provider.of<Data>(context).currentCard()),
                  Visibility(
                      visible: Provider.of<Data>(context).countIsVisible,
                      child: Text('${Provider.of<Data>(context).count}',
                          style: TextStyle(fontSize: 42, color: Colors.black)))
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
}
