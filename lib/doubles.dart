import 'package:blackjack/playing_card.dart';
import 'main.dart';

Decision checkForDoubles(
    PlayingCard playerCard1, PlayingCard playerCard2, PlayingCard dealerCard) {
  Decision result = Decision.none;
  //After processing splits and soft hands, only other doubles are
  //player totals=9, 10, 11
  int total = computeHandValue(playerCard1, playerCard2);
  if (total == 9) {
    //Double if upcard is 4, 5, or 6, otherwise hit
    if (dealerCard.value == CardValue.four ||
        dealerCard.value == CardValue.five ||
        dealerCard.value == CardValue.six) {
      result = Decision.double;
    } else
      result = Decision.hit;
  } else if (total == 10) {
    //Double if upcard is 2-9, hit 10, A
    if (cardValueToNumber(dealerCard) < 10) {
      result = Decision.double;
    } else
      result = Decision.hit;
  } else if (total == 11) {
    //Double 2-10, hit A
    if (dealerCard.value == CardValue.ace) {
      result = Decision.hit;
    } else
      result = Decision.double;
  }

  return result;
}
