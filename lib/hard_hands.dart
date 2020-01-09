import 'package:blackjack/playing_card.dart';
import 'main.dart';

Decision processHardHand(
    PlayingCard playerCard1, PlayingCard playerCard2, PlayingCard dealerCard) {
  Decision result = Decision.none;
  int total = computeHandValue(playerCard1, playerCard2);
  //if total's 8 or less, always hit
  if (total <= 8) {
    result = Decision.hit;
  }
  //9, 10, and 11 dealt with in doubles.dart

  //12 hits with dealerCard 2, 3, stands with 4, 5, 6, hits with 7 or higher
  if (total == 12) {
    if (dealerCard.value == CardValue.four ||
        dealerCard.value == CardValue.five ||
        dealerCard.value == CardValue.six) {
      result = Decision.stand;
    } else {
      result = Decision.hit;
    }
  }

  //13 to 16 depend on dealerCard
  if (total >= 13 && total <= 16) {
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
