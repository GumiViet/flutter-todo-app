import 'package:flutter/material.dart';
import 'package:flutter_to_do/@shared/utils/utils.dart';
import 'package:flutter_to_do/resources/styles/images.dart';
import 'package:flutter_to_do/screens/base_screen.dart';
import 'package:flutter_to_do/screens/home/stack/card/stack_card.dart';
import 'package:flutter_to_do/screens/home/stack/card_set/stack_card_set.dart';
import 'package:flutter_to_do/screens/home/stack/card_view/stack_card_view.dart';

class MatchingScreen extends StatefulWidget {
  @override
  _MatchingScreenState createState() => _MatchingScreenState();
}


var cardSet = StackedCardSet(cards: [
  StackedCard(
    photos: [
      AppImages.imgDemo_1,
      AppImages.imgDemo_2,
    ],
    title: 'Your Name 1',
    subTitle: 'And Biography 1',
  ),
  StackedCard(
    photos: [
      AppImages.imgDemo_2,
      AppImages.imgDemo_3,
    ],
    title: 'Your Name 2',
    subTitle: 'And Biography 2',
  ),
  StackedCard(
    photos: [
      AppImages.imgDemo_3,
      AppImages.imgDemo_4,
    ],
    title: 'Your Name 3',
    subTitle: 'And Biography 3',
  ),
  StackedCard(
    photos: [
      AppImages.imgDemo_4,
      AppImages.imgDemo_5,
    ],
    title: 'Your Name 4',
    subTitle: 'And Biography 4',
  ),
  StackedCard(
    photos: [
      AppImages.imgDemo_5,
      AppImages.imgDemo_6,
    ],
    title: 'Your Name 5',
    subTitle: 'And Biography 5',
  ),
  StackedCard(
    photos: [
      AppImages.imgDemo_6,
      AppImages.imgDemo_7,
    ],
    title: 'Your Name 6',
    subTitle: 'And Biography 6',
  ),
  StackedCard(
    photos: [
      AppImages.imgDemo_7,
      AppImages.imgDemo_1,
    ],
    title: 'Your Name 7',
    subTitle: 'And Biography 7',
  )
]);

class _MatchingScreenState extends BaseScreen<MatchingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidthWithPercent(100),
      child: StackedCardView(
        cardSet: cardSet,
      ),
    );
  }
}
