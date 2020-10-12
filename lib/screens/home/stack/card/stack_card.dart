import 'package:flutter/material.dart';
import 'package:flutter_to_do/@core/enums.dart';

class StackedCard extends ChangeNotifier {
  final List<String> photos;
  final String title;
  final String subTitle;

  SlideDirection direction;

  StackedCard({
    @required this.photos,
    @required this.title,
    this.subTitle,
  });

  void slideLeft() {
    direction = SlideDirection.Left;
    notifyListeners();
  }

  void slideRight() {
    direction = SlideDirection.Right;
    notifyListeners();
  }

  // void slideUp() {
    // direction = SlideDirection.Up;
    // notifyListeners();
  // }
}
