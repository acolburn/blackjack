import 'package:blackjack/playing_card.dart';
import 'main.dart';

Decision checkForDoubles(PlayingCard playerCard1, PlayingCard playerCard2,
    PlayingCard dealerCard, bool isHighCount) {
  Decision result = Decision.none;
  //After processing splits and soft hands, only other doubles are
  //player totals=9, 10, 11 (except for high count adjustments)
  int total = computeHandValue(playerCard1, playerCard2);

  //-------------------Start total = 9-------------------
  //most of time 9 hits
  if (total == 9) {
    result = Decision.hit;
  }
  //Adjustment for high count: 9 doubles against 3 or 7
  if (total == 9 && isHighCount && dealerCard.value == CardValue.three) {
    result = Decision.double;
  }
  if (total == 9 && isHighCount && dealerCard.value == CardValue.seven) {
    result = Decision.double;
  }

  //9 always doubles against 4, 5, or 6
  if (total == 9 &&
      (dealerCard.value == CardValue.four ||
          dealerCard.value == CardValue.five ||
          dealerCard.value == CardValue.six)) {
    result = Decision.double;
  }
  //-------------------End total = 9------------------

  //-------------------Start total = 10---------------
  if (total == 10) {
    //Adjustment for high count: 10 always doubles
    if (isHighCount) {
      result = Decision.double;
    }
    //rest of the time double if upcard is 2-9, hit 10, A
    else if (cardValueToNumber(dealerCard) < 10) {
      result = Decision.double;
    } else
      result = Decision.hit;
  }
  //-------------------End total = 10------------------

  //-------------------Start total = 11----------------
  if (total == 11) {
    //Adjustment for high count: 11 always doubles
    if (isHighCount) {
      result = Decision.double;
    }
    //Double 2-10, hit A
    else if (dealerCard.value == CardValue.ace) {
      result = Decision.hit;
    } else
      result = Decision.double;
  }
  //--------------------End total=11--------------------

  return result;
}
