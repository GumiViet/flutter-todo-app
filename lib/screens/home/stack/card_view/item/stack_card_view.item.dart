import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_to_do/@core/enums.dart';
import 'package:flutter_to_do/@core/repo/matching/matching.model.dart';
import 'package:flutter_to_do/screens/home/stack/card_view/content/stack_card_view.item.content.dart';
import 'package:fluttery_dart2/layout.dart';

class StackedCardViewItem extends StatefulWidget {
  final bool isDraggable;
  final MatchingModel card;
  final Function(double, double) onSlideUpdate;
  final double scale;
  final bool statusComplete;
  double handleLeftRight;

  StackedCardViewItem({
    Key key,
    this.isDraggable: true,
    @required this.card,
    this.onSlideUpdate,
    this.scale: 1.0,
    this.statusComplete: true,
  }) : super(key: key);

  @override
  _StackedCardViewItemState createState() => _StackedCardViewItemState();
}

class _StackedCardViewItemState extends State<StackedCardViewItem>
    with TickerProviderStateMixin {
  GlobalKey itemKey = GlobalKey(debugLabel: 'item_key');

  Offset containerOffset = const Offset(0.0, 0.0);
  Offset dragStartPosition;
  Offset dragCurrentPosition;
  Offset slideBackStartPosition;

  AnimationController slideBackAnimation;
  AnimationController slideOutAnimation;
  Tween<Offset> slideOutTween;
  SlideDirection slideOutDirection = SlideDirection.Up;

  @override
  void initState() {
    super.initState();

    slideBackAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )
      ..addListener(() => setState(() {
            containerOffset = Offset.lerp(
                slideBackStartPosition,
                const Offset(0.0, 0.0),
                Curves.elasticOut.transform(slideBackAnimation.value));
            if (widget.onSlideUpdate != null &&
                slideOutDirection == SlideDirection.Up) {
              if (containerOffset.distance == 1)
                print("addListener - ${containerOffset.distance}");
              widget.onSlideUpdate(
                  containerOffset.distance, widget.handleLeftRight);
            }
          }))
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            print("addListener - ${containerOffset.distance}");
            dragStartPosition = null;
            dragCurrentPosition = null;
            slideBackStartPosition = null;
          });
        }
      });

    slideOutAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )
      ..addListener(() => setState(() {
            containerOffset = slideOutTween.evaluate(slideOutAnimation);
            if (widget.onSlideUpdate != null) {
              widget.onSlideUpdate(
                  containerOffset.distance, widget.handleLeftRight);
            }
          }))
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            dragStartPosition = null;
            dragCurrentPosition = null;
            slideOutTween = null;
          });
        }
      });
  }

  @override
  void dispose() {
    slideBackAnimation.dispose();
    slideOutAnimation.dispose();
    super.dispose();
  }

  void _onPanStart(DragStartDetails details) {
    if (!widget.isDraggable) return;
    dragStartPosition = details.globalPosition;
    if (slideBackAnimation.isAnimating) slideBackAnimation.stop();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    widget.handleLeftRight = containerOffset.dx / context.size.width;
    if (!widget.isDraggable) return;
    setState(() {
      dragCurrentPosition = details.globalPosition;
      containerOffset = dragCurrentPosition - dragStartPosition;
      if (widget.onSlideUpdate != null)
        widget.onSlideUpdate(containerOffset.distance, widget.handleLeftRight);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (!widget.isDraggable) return;
    final isInLeftRegion = (containerOffset.dx / context.size.width) < -0.25;
    final isInRightRegion = (containerOffset.dx / context.size.width) > 0.25;
    setState(() {
      slideOutDirection = isInLeftRegion || isInRightRegion
          ? isInLeftRegion
              ? SlideDirection.Left
              : SlideDirection.Right
          : SlideDirection.Up;
      slideBackStartPosition = containerOffset;
      slideBackAnimation.forward(from: 0.0);
    });
  }

  double _rotation(Rect dragBounds) {
    if (dragStartPosition != null) {
      final rotationCornerMultiplier =
          dragStartPosition.dy >= dragBounds.top + (dragBounds.height / 2)
              ? -1
              : 1;
      final angle = (pi / 8) * (containerOffset.dx / dragBounds.width);
      return angle * rotationCornerMultiplier;
    } else {
      return 0.0;
    }
  }

  Offset _rotationOrigin(Rect dragBounds) {
    if (dragStartPosition != null) {
      return dragStartPosition - dragBounds.topLeft;
    } else {
      return const Offset(0.0, 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return getChild();
  }

  Widget getChild() {
    return AnchoredOverlay(
      showOverlay: true,
      child: Center(),
      overlayBuilder: (BuildContext context, Rect anchorBounds, Offset anchor) {
        return CenterAbout(
          position: anchor,
          child: Transform(
            transform: Matrix4.translationValues(
                containerOffset.dx, containerOffset.dy, 0.0)
              ..rotateZ(_rotation(anchorBounds))
              ..scale(widget.scale, widget.scale),
            origin: _rotationOrigin(anchorBounds),
            alignment: widget.scale != 1.0 ? Alignment.center : null,
            child: Container(
              key: itemKey,
              width: anchorBounds.width,
              height: anchorBounds.height,
              child: GestureDetector(
                onPanStart: _onPanStart,
                onPanUpdate: _onPanUpdate,
                onPanEnd: _onPanEnd,
                child: StackedCardViewItemContent(
                  model: widget.card,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
