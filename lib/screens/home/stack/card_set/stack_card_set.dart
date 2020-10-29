import 'package:flutter/material.dart';
import 'package:flutter_to_do/@core/repo/matching/matching.model.dart';

class StackedCardSet {
  final List<MatchingModel> cards;

  int _currentCardIndex = 0;

  int get currentCardIndex => _currentCardIndex;

  StackedCardSet({@required this.cards});

  void incrementCardIndex() {
    _currentCardIndex = _currentCardIndex < cards.length - 1
        ? _currentCardIndex + 1
        : _currentCardIndex;
  }

  MatchingModel getFirstCard() {
    return cards[_currentCardIndex];
  }

  MatchingModel getNextCard() {
    return _currentCardIndex < cards.length - 1
        ? cards[_currentCardIndex + 1]
        : null;
  }

  String getKey() {
    return getFirstCard().fullName;
  }
}
