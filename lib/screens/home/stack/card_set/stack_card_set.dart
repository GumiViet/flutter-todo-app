import 'package:flutter/material.dart';
import 'package:flutter_to_do/screens/home/stack/card/stack_card.dart';

class StackedCardSet {
  final List<StackedCard> cards;

  int _currentCardIndex = 0;

  int get currentCardIndex => _currentCardIndex;

  StackedCardSet({@required this.cards});

  void incrementCardIndex() {
    _currentCardIndex = _currentCardIndex < cards.length - 1
        ? _currentCardIndex + 1
        : _currentCardIndex;
  }

  StackedCard getFirstCard() {
    return cards[_currentCardIndex];
  }

  StackedCard getNextCard() {
    return _currentCardIndex < cards.length - 1
        ? cards[_currentCardIndex + 1]
        : null;
  }

  String getKey() {
    return getFirstCard().title;
  }
}
