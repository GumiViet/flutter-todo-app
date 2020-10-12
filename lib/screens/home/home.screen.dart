import 'package:flutter/material.dart';
import 'package:flutter_to_do/resources/styles/images.dart';
import 'package:flutter_to_do/screens/home/stack/card/stack_card.dart';
import 'package:flutter_to_do/screens/home/stack/card_view/stack_card_view.dart';

import 'stack/card_set/stack_card_set.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

var cardSet = StackedCardSet(cards: [
  StackedCard(
    photos: [
      AppImages.img_demo_1,
    ],
    title: 'Your Name 1',
    subTitle: 'And Biography 1',
  ),
  StackedCard(
    photos: [
      AppImages.img_demo_2,
    ],
    title: 'Your Name 2',
    subTitle: 'And Biography 2',
  ),
  StackedCard(
    photos: [
      AppImages.img_demo_3,
    ],
    title: 'Your Name 3',
    subTitle: 'And Biography 3',
  ),
  StackedCard(
    photos: [
      AppImages.img_demo_4,
    ],
    title: 'Your Name 4',
    subTitle: 'And Biography 4',
  ),
  StackedCard(
    photos: [
      AppImages.img_demo_5,
    ],
    title: 'Your Name 5',
    subTitle: 'And Biography 5',
  ),
  StackedCard(
    photos: [
      AppImages.img_demo_6,
    ],
    title: 'Your Name 6',
    subTitle: 'And Biography 6',
  ),
  StackedCard(
    photos: [
      AppImages.img_demo_7,
    ],
    title: 'Your Name 7',
    subTitle: 'And Biography 7',
  )
]);

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      child: StackedCardView(
        cardSet: cardSet,
      ),
    );
  }
}
