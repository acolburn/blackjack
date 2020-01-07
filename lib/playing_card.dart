import 'package:flutter/material.dart';

enum CardSuit { S, H, D, C }

enum CardValue {
  ace,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  ten,
  jack,
  queen,
  king
}

class PlayingCard {
  CardSuit suit;
  CardValue value;

  PlayingCard({@required this.value, @required this.suit});
}

List<PlayingCard> makeDeck() {
  List<PlayingCard> deck = [];
  // make standard 52 card deck
  CardSuit.values.forEach((suit) {
    CardValue.values.forEach((type) {
      deck.add(PlayingCard(
        value: type,
        suit: suit,
      ));
    });
  });
//  }
  return deck;
}

Widget buildFaceDownCard() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      color: Colors.red[200],
      border: Border.all(color: Colors.black),
    ),
    height: 120.0,
    width: 80,
  );
}

Widget buildCard(PlayingCard aCard) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      color: Colors.white,
      border: Border.all(color: Colors.black),
    ),
    height: 120.0,
    width: 80,
    child: Row(
      children: <Widget>[
        Text(
          cardValueToString(aCard),
          style: TextStyle(
            fontSize: 32.0,
            color: suitColor(aCard),
          ),
        ),
        Expanded(
          child: Container(
            height: 30.0,
            child: suitToImage(aCard),
          ),
        ),
      ],
    ),
  );
}

Color suitColor(PlayingCard aCard) {
  if (aCard.suit == CardSuit.D || aCard.suit == CardSuit.H) {
    return Colors.red;
  } else {
    return Colors.black;
  }
}

String cardValueToString(PlayingCard aCard) {
  switch (aCard.value) {
    case CardValue.ace:
      return "A";
    case CardValue.two:
      return "2";
    case CardValue.three:
      return "3";
    case CardValue.four:
      return "4";
    case CardValue.five:
      return "5";
    case CardValue.six:
      return "6";
    case CardValue.seven:
      return "7";
    case CardValue.eight:
      return "8";
    case CardValue.nine:
      return "9";
    case CardValue.ten:
      return "10";
    case CardValue.jack:
      return "J";
    case CardValue.queen:
      return "Q";
    case CardValue.king:
      return "K";
    default:
      return "";
  }
}

Image suitToImage(PlayingCard aCard) {
  switch (aCard.suit) {
    case CardSuit.H:
      return Image.asset('images/hearts.png');
    case CardSuit.D:
      return Image.asset('images/diamonds.png');
    case CardSuit.C:
      return Image.asset('images/clubs.png');
    case CardSuit.S:
      return Image.asset('images/spades.png');
    default:
      return null;
  }
}
