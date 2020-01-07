import 'package:blackjack/playing_card.dart';

bool testForSplit(
    PlayingCard playerCard1, PlayingCard playerCard2, PlayingCard dealerCard) {
  bool shouldSplit = false;
  if (playerCard1.value != playerCard2.value) {
    shouldSplit = false;
  } else {
    switch (playerCard1.value) {
      case CardValue.ace:
        shouldSplit = true;
        break;
      case CardValue.eight:
        shouldSplit = true;
        break;
      case CardValue.five:
        shouldSplit = false;
        break;
      case CardValue.ten:
        shouldSplit = false;
        break;
      case CardValue.jack:
        shouldSplit = false;
        break;
      case CardValue.queen:
        shouldSplit = false;
        break;
      case CardValue.king:
        shouldSplit = false;
        break;
      case CardValue.two:
        if (dealerCard.value == CardValue.two ||
            dealerCard.value == CardValue.three ||
            dealerCard.value == CardValue.four ||
            dealerCard.value == CardValue.five ||
            dealerCard.value == CardValue.six ||
            dealerCard.value == CardValue.seven) {
          shouldSplit = true;
        } else {
          shouldSplit = false;
        }
        break;
      case CardValue.three:
        if (dealerCard.value == CardValue.two ||
            dealerCard.value == CardValue.three ||
            dealerCard.value == CardValue.four ||
            dealerCard.value == CardValue.five ||
            dealerCard.value == CardValue.six ||
            dealerCard.value == CardValue.seven) {
          shouldSplit = true;
        } else {
          shouldSplit = false;
        }
        break;
      case CardValue.seven:
        if (dealerCard.value == CardValue.two ||
            dealerCard.value == CardValue.three ||
            dealerCard.value == CardValue.four ||
            dealerCard.value == CardValue.five ||
            dealerCard.value == CardValue.six ||
            dealerCard.value == CardValue.seven) {
          shouldSplit = true;
        } else {
          shouldSplit = false;
        }
        break;
      case CardValue.six:
        if (dealerCard.value == CardValue.two ||
            dealerCard.value == CardValue.three ||
            dealerCard.value == CardValue.four ||
            dealerCard.value == CardValue.five ||
            dealerCard.value == CardValue.six) {
          shouldSplit = true;
        } else {
          shouldSplit = false;
        }
        break;
      case CardValue.four:
        if (dealerCard.value == CardValue.four ||
            dealerCard.value == CardValue.five ||
            dealerCard.value == CardValue.six) {
          shouldSplit = true;
        } else {
          shouldSplit = false;
        }
        break;
      case CardValue.nine:
        if (dealerCard.value == CardValue.seven ||
            dealerCard.value == CardValue.ten ||
            dealerCard.value == CardValue.jack ||
            dealerCard.value == CardValue.queen ||
            dealerCard.value == CardValue.king) {
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
