import 'package:blackjack/playing_card.dart';
import 'main.dart';

Decision testForSplit(
    PlayingCard playerCard1, PlayingCard playerCard2, PlayingCard dealerCard) {
  Decision result = Decision.none;
  if (playerCard1.value != playerCard2.value) {
    result = Decision.none;
  } else {
    switch (playerCard1.value) {
      case CardValue.ace:
        result = Decision.split;
        break;
      case CardValue.eight:
        result = Decision.split;
        break;
      case CardValue.five:
        if (dealerCard.value == CardValue.ten ||
            dealerCard.value == CardValue.jack ||
            dealerCard.value == CardValue.queen ||
            dealerCard.value == CardValue.king ||
            dealerCard.value == CardValue.ace) {
          result = Decision.hit;
        } else {
          result = Decision.double;
        }
        break;
      case CardValue.ten:
        result = Decision.stand;
        break;
      case CardValue.jack:
        result = Decision.stand;
        break;
      case CardValue.queen:
        result = Decision.stand;
        break;
      case CardValue.king:
        result = Decision.stand;
        break;
      case CardValue.two:
        if (dealerCard.value == CardValue.two ||
            dealerCard.value == CardValue.three ||
            dealerCard.value == CardValue.four ||
            dealerCard.value == CardValue.five ||
            dealerCard.value == CardValue.six ||
            dealerCard.value == CardValue.seven) {
          result = Decision.split;
        } else {
          result = Decision.hit;
        }
        break;
      case CardValue.three:
        if (dealerCard.value == CardValue.two ||
            dealerCard.value == CardValue.three ||
            dealerCard.value == CardValue.four ||
            dealerCard.value == CardValue.five ||
            dealerCard.value == CardValue.six ||
            dealerCard.value == CardValue.seven) {
          result = Decision.split;
        } else {
          result = Decision.hit;
        }
        break;
      case CardValue.seven:
        if (dealerCard.value == CardValue.two ||
            dealerCard.value == CardValue.three ||
            dealerCard.value == CardValue.four ||
            dealerCard.value == CardValue.five ||
            dealerCard.value == CardValue.six ||
            dealerCard.value == CardValue.seven) {
          result = Decision.split;
        } else {
          result = Decision.hit;
        }
        break;
      case CardValue.six:
        if (dealerCard.value == CardValue.two ||
            dealerCard.value == CardValue.three ||
            dealerCard.value == CardValue.four ||
            dealerCard.value == CardValue.five ||
            dealerCard.value == CardValue.six) {
          result = Decision.split;
        } else {
          result = Decision.hit;
        }
        break;
      case CardValue.four:
        if (dealerCard.value == CardValue.five ||
            dealerCard.value == CardValue.six) {
          result = Decision.split;
        } else {
          result = Decision.hit;
        }
        break;
      case CardValue.nine:
        if (dealerCard.value == CardValue.seven ||
            dealerCard.value == CardValue.ten ||
            dealerCard.value == CardValue.jack ||
            dealerCard.value == CardValue.queen ||
            dealerCard.value == CardValue.king ||
            dealerCard.value == CardValue.ace) {
          result = Decision.stand;
        } else {
          result = Decision.split;
        }
        break;
      default:
        result = Decision.none;
    }
  }
  return result;
}
