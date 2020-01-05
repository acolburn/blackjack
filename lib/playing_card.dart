import 'package:flutter/material.dart';

enum CardSuit { S, H, D, C }

enum CardType {
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
  CardType type;
  bool faceUp;

  PlayingCard({@required this.type, @required this.suit, this.faceUp = true});
}

List<PlayingCard> makeDeck() {
  List<PlayingCard> deck = [];
  // make standard 52 card deck
  CardSuit.values.forEach((suit) {
    CardType.values.forEach((type) {
      deck.add(PlayingCard(
        type: type,
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
          cardTypeToString(aCard),
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

String cardTypeToString(PlayingCard aCard) {
  switch (aCard.type) {
    case CardType.ace:
      return "A";
    case CardType.two:
      return "2";
    case CardType.three:
      return "3";
    case CardType.four:
      return "4";
    case CardType.five:
      return "5";
    case CardType.six:
      return "6";
    case CardType.seven:
      return "7";
    case CardType.eight:
      return "8";
    case CardType.nine:
      return "9";
    case CardType.ten:
      return "10";
    case CardType.jack:
      return "J";
    case CardType.queen:
      return "Q";
    case CardType.king:
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
