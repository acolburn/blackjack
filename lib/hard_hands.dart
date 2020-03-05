import 'package:blackjack/playing_card.dart';
import 'main.dart';

Decision processHardHand(PlayingCard playerCard1, PlayingCard playerCard2,
    PlayingCard dealerCard, bool isHighCount) {
  Decision result = Decision.none;
  int total = computeHandValue(playerCard1, playerCard2);

  //if total's 8 or less, always hit
  //except in the special case of a high count, where 8 doubles against a 5 or 6
  if (total <= 8) {
    result = Decision.hit;
  }
  if (isHighCount && total == 8) {
    if (dealerCard.value == CardValue.five ||
        dealerCard.value == CardValue.six) {
      result = Decision.double;
    }
  }

  //9, 10, and 11 dealt with in doubles.dart

  //if count is high, 12 stands against a 2,3; rest of time 12 hits against 2,3
  if (total == 12) {
    if (dealerCard.value == CardValue.two ||
        dealerCard.value == CardValue.three) {
      if (isHighCount) {
        result = Decision.stand;
      } else {
        result = Decision.hit;
      }
    }
    //12 stands against 4, 5, 6
    else if (dealerCard.value == CardValue.four ||
        dealerCard.value == CardValue.five ||
        dealerCard.value == CardValue.six) {
      result = Decision.stand;
    } else {
      //12 hits against everything else, i.e., 7 or higher
      result = Decision.hit;
    }
  }

  //13 to 16 depend on dealerCard
  //when count is high, 15 and 16 stand against a 10
  if (isHighCount && total == 16 && cardValueToNumber(dealerCard) == 10) {
    result = Decision.stand;
  } else if (isHighCount &&
      total == 15 &&
      cardValueToNumber(dealerCard) == 10) {
    result = Decision.stand;
    //rest of time, everything between 13 and 16 hits against 7 and up, stands against 6 or less
  } else if (total >= 13 && total <= 16) {
    if (cardValueToNumber(dealerCard) <= 6) {
      result = Decision.stand;
    } else {
      result = Decision.hit;
    }
  }

  //17 or more always stands
  if (total >= 17) {
    result = Decision.stand;
  }

  return result;
}
