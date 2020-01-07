import 'package:blackjack/playing_card.dart';

bool testForSplit(
    PlayingCard playerCard1, PlayingCard playerCard2, PlayingCard dealerCard) {
  bool shouldSplit = false;
  if (playerCard1.type != playerCard2.type) {
    shouldSplit = false;
  } else {
    switch (playerCard1.type) {
      case CardType.ace:
        shouldSplit = true;
        break;
      case CardType.eight:
        shouldSplit = true;
        break;
      case CardType.five:
        shouldSplit = false;
        break;
      case CardType.ten:
        shouldSplit = false;
        break;
      case CardType.jack:
        shouldSplit = false;
        break;
      case CardType.queen:
        shouldSplit = false;
        break;
      case CardType.king:
        shouldSplit = false;
        break;
      case CardType.two:
        if (dealerCard.type == CardType.two ||
            dealerCard.type == CardType.three ||
            dealerCard.type == CardType.four ||
            dealerCard.type == CardType.five ||
            dealerCard.type == CardType.six ||
            dealerCard.type == CardType.seven) {
          shouldSplit = true;
        } else {
          shouldSplit = false;
        }
        break;
      case CardType.three:
        if (dealerCard.type == CardType.two ||
            dealerCard.type == CardType.three ||
            dealerCard.type == CardType.four ||
            dealerCard.type == CardType.five ||
            dealerCard.type == CardType.six ||
            dealerCard.type == CardType.seven) {
          shouldSplit = true;
        } else {
          shouldSplit = false;
        }
        break;
      case CardType.seven:
        if (dealerCard.type == CardType.two ||
            dealerCard.type == CardType.three ||
            dealerCard.type == CardType.four ||
            dealerCard.type == CardType.five ||
            dealerCard.type == CardType.six ||
            dealerCard.type == CardType.seven) {
          shouldSplit = true;
        } else {
          shouldSplit = false;
        }
        break;
      case CardType.six:
        if (dealerCard.type == CardType.two ||
            dealerCard.type == CardType.three ||
            dealerCard.type == CardType.four ||
            dealerCard.type == CardType.five ||
            dealerCard.type == CardType.six) {
          shouldSplit = true;
        } else {
          shouldSplit = false;
        }
        break;
      case CardType.four:
        if (dealerCard.type == CardType.four ||
            dealerCard.type == CardType.five ||
            dealerCard.type == CardType.six) {
          shouldSplit = true;
        } else {
          shouldSplit = false;
        }
        break;
      case CardType.nine:
        if (dealerCard.type == CardType.seven ||
            dealerCard.type == CardType.ten ||
            dealerCard.type == CardType.jack ||
            dealerCard.type == CardType.queen ||
            dealerCard.type == CardType.king) {
          shouldSplit = false;
        } else {
          shouldSplit = true;
        }
        break;
      default:
        shouldSplit = false;
    }
  }
  return shouldSplit;
}
