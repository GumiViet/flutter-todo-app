import 'package:flutter_to_do/@core/enums.dart';
import 'package:flutter_to_do/@core/services/view_state.service.dart';

class StackCardViewViewModel extends ViewStateModel {
  SlideDirection _slideDirection = SlideDirection.Up;

  SlideDirection get slideDirection => _slideDirection;

  double _distance = 0.0;

  double get distance => _distance;

  set distance(val) {
    _distance = val;
    notifyListeners();
  }

  double _draggable = 0.0;

  double get draggable => _draggable;

  set draggable(val) {
    _draggable = val;
    notifyListeners();
  }

  void setDistanceAndDraggable(double distance, double draggable) {
    _distance = 0.8 + (0.2 * (distance / 100.0)).clamp(0.0, 0.2);
    if (draggable != null) _draggable = draggable;
    _slideDirection = distance == 0
        ? SlideDirection.Up
        : _draggable > 0
            ? SlideDirection.Right
            : SlideDirection.Left;
    notifyListeners();
  }
}
