import 'package:flutter/material.dart';
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
              padding: const EdgeInsets.all(8.0),
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
                  makeInfoCellButton(name: 'Autocountdown', action: () {})
                ],
              ),
            ),
            //Expanded() widgets help place card location on screen
            //adds space between buttons (on left) & card/count (in middle)
            Expanded(flex: 1, child: Container()),
            GestureDetector(
              onTap: () {
                if (i < 51) {
                  setState(() {
                    i++;
                    if (cardValueToNumber(deck[i]) >= 10) {
                      count--;
                    } else if (cardValueToNumber(deck[i]) <= 7) {
                      count++;
                    }
                  });
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildCard(deck[i]),
                  Visibility(
                      visible: isVisible,
                      child: Text('$count',
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

  void resetDeck() {
    deck.shuffle();
    setState(() {
      i = 0;
      if (cardValueToNumber(deck[0]) >= 10) {
        count = -1;
      } else if (cardValueToNumber(deck[0]) <= 7) {
        count = 1;
      } else
        count = 0;
    });
  }
}
