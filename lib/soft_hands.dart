import 'package:blackjack/playing_card.dart';
import 'main.dart';

Decision processSoftHand(
    PlayingCard playerCard1, PlayingCard playerCard2, PlayingCard dealerCard) {
  Decision result = Decision.none;
  PlayingCard temp;
  if (playerCard1.value == CardValue.ace) {
    temp = playerCard2;
  } else {
    temp = playerCard1;
  }
  switch (temp.value) {
    case CardValue.ace:
      result = Decision.split; //dupe from splits.dart
      break;
    case CardValue.two:
      if (dealerCard.value == CardValue.five ||
          dealerCard.value == CardValue.six) {
        result = Decision.double;
      } else
        result = Decision.hit;
      break;
    case CardValue.three:
      if (dealerCard.value == CardValue.five ||
          dealerCard.value == CardValue.six) {
        result = Decision.double;
      } else
        result = Decision.hit;
      break;
    case CardValue.four:
      if (dealerCard.value == CardValue.four ||
          dealerCard.value == CardValue.five ||
          dealerCard.value == CardValue.six) {
        result = Decision.double;
      } else
        result = Decision.hit;
      break;
    case CardValue.five:
      if (dealerCard.value == CardValue.four ||
          dealerCard.value == CardValue.five ||
          dealerCard.value == CardValue.six) {
        result = Decision.double;
      } else
        result = Decision.hit;
      break;
    case CardValue.six:
      if (dealerCard.value == CardValue.three ||
          dealerCard.value == CardValue.four ||
          dealerCard.value == CardValue.five ||
          dealerCard.value == CardValue.six) {
        result = Decision.double;
      } else
        result = Decision.hit;
      break;
    case CardValue.seven:
      if (dealerCard.value == CardValue.two ||
          dealerCard.value == CardValue.three ||
          dealerCard.value == CardValue.four ||
          dealerCard.value == CardValue.five ||
          dealerCard.value == CardValue.six) {
        result = Decision.double;
      } else if (dealerCard.value == CardValue.seven ||
          dealerCard.value == CardValue.eight) {
        result = Decision.stand;
      } else
        result = Decision.hit;
      break;
    case CardValue.eight:
      if (dealerCard.value == CardValue.six) {
        result = Decision.double;
      } else
        result = Decision.stand;
      break;
    case CardValue.nine:
      result = Decision.stand;
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
    default:
      result = Decision.none;
  }
  return result;
}
