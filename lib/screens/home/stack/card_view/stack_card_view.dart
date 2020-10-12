import 'package:flutter/material.dart';
import 'package:flutter_to_do/@core/enums.dart';
import 'package:flutter_to_do/screens/home/stack/card_set/stack_card_set.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'item/stack_card_view.item.dart';

class StackedCardView extends StatefulWidget {
  final StackedCardSet cardSet;

  StackedCardView({@required this.cardSet});

  @override
  _StackedCardViewState createState() => _StackedCardViewState();
}

class _StackedCardViewState extends State<StackedCardView> {
  double _nextCardScale = 0.0;
  Key _frontItemKey;

  @override
  void initState() {
    super.initState();
    _setItemKey();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: getChild(),
        )
      ],
    );
  }

  void _setItemKey() {
    _frontItemKey = Key(widget.cardSet.getKey());
  }

  void _onSlideUpdate(double distance) {
    setState(() {
      _nextCardScale = 0.9 + (0.1 * (distance / 100.0)).clamp(0.0, 0.1);
    });
  }

  void _onSlideComplete(SlideDirection direction) {
    switch (direction) {
      case SlideDirection.Left:
        Fluttertoast.showToast(msg: "Swipe remove");
        break;
      case SlideDirection.Right:
        Fluttertoast.showToast(msg: "Swipe accept");
        break;
      case SlideDirection.Up:
        Fluttertoast.showToast(msg: "Swipe Up");
        break;
    }
    setState(() {
      widget.cardSet.incrementCardIndex();
      _setItemKey();
    });
  }

  Widget _buildBackItem() {
    return StackedCardViewItem(
        isDraggable: true,
        card: widget.cardSet.getNextCard(),
        scale: _nextCardScale);
  }

  Widget _buildFrontItem() {
    return StackedCardViewItem(
      key: _frontItemKey,
      onSlideUpdate: _onSlideUpdate,
      statusComplete:
          widget.cardSet.currentCardIndex < widget.cardSet.cards.length - 1,
      onSlideComplete: _onSlideComplete,
      card: widget.cardSet.getFirstCard(),
    );
  }

  Widget getChild() {
    return Stack(
      children: <Widget>[
        _buildBackItem(),
        _buildFrontItem(),
      ],
    );
  }
}
