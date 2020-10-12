import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_to_do/@core/enums.dart';
import 'package:flutter_to_do/screens/home/stack/card/stack_card.dart';
import 'package:flutter_to_do/screens/home/stack/card_view/content/stack_card_view.item.content.dart';
import 'package:fluttery_dart2/layout.dart';

class StackedCardViewItem extends StatefulWidget {
  final bool isDraggable;
  final StackedCard card;
  final Function(double) onSlideUpdate;
  final Function(SlideDirection) onSlideComplete;
  final double scale;
  final bool statusComplete;

  StackedCardViewItem({
    Key key,
    this.isDraggable: true,
    @required this.card,
    this.onSlideUpdate,
    this.onSlideComplete,
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
  SlideDirection slideOutDirection;

  @override
  void initState() {
    super.initState();

    slideBackAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )
      ..addListener(() => setState(() {
            containerOffset = Offset.lerp(
                slideBackStartPosition,
                const Offset(0.0, 0.0),
                Curves.elasticOut.transform(slideBackAnimation.value));
            if (widget.onSlideUpdate != null) {
              widget.onSlideUpdate(containerOffset.distance);
            }
          }))
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            dragStartPosition = null;
            dragCurrentPosition = null;
            slideBackStartPosition = null;
          });
        }
      });

    slideOutAnimation = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )
      ..addListener(() => setState(() {
            containerOffset = slideOutTween.evaluate(slideOutAnimation);
            if (widget.onSlideUpdate != null) {
              widget.onSlideUpdate(containerOffset.distance);
            }
          }))
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            dragStartPosition = null;
            dragCurrentPosition = null;
            slideOutTween = null;
            if (widget.onSlideComplete != null) {
              widget.onSlideComplete(slideOutDirection);
            }
          });
        }
      });

    if (widget.isDraggable) {
      widget.card.addListener(_slideFromExternal);
    }
  }

  void _slideFromExternal() {
    switch (widget.card.direction) {
      case SlideDirection.Left:
        _slideLeft();
        break;
      case SlideDirection.Right:
        _slideRight();
        break;
      case SlideDirection.Up:
        _slideUp();
        break;
    }
  }

  void _slideLeft() {
    if (slideOutAnimation.isAnimating) {
      return;
    }
    final screenSize = MediaQuery.of(context).size;
    dragStartPosition = _randomDragStartPosition();
    slideOutTween = Tween(
        begin: const Offset(0.0, 0.0), end: Offset(screenSize.width * -2, 0.0));
    slideOutAnimation.forward(from: 0.0);
    slideOutDirection = SlideDirection.Left;
  }

  /// 右にスワイプされた際の処理です
  void _slideRight() {
    if (slideOutAnimation.isAnimating) {
      return;
    }

    final screenSize = MediaQuery.of(context).size;
    dragStartPosition = _randomDragStartPosition();
    slideOutTween = Tween(
        begin: const Offset(0.0, 0.0), end: Offset(screenSize.width * 2, 0.0));
    slideOutAnimation.forward(from: 0.0);
    slideOutDirection = SlideDirection.Right;
  }

  void _slideUp() {
    if (slideOutAnimation.isAnimating) {
      return;
    }

    final screenSize = MediaQuery.of(context).size;
    dragStartPosition = _randomDragStartPosition();
    slideOutTween = Tween(
        begin: const Offset(0.0, 0.0),
        end: Offset(0.0, screenSize.height * -2));
    slideOutAnimation.forward(from: 0.0);
    slideOutDirection = SlideDirection.Up;
  }

  Offset _randomDragStartPosition() {
    final screenSize = MediaQuery.of(context).size;

    final itemContext = itemKey.currentContext;
    final itemTopLeft = (itemContext.findRenderObject() as RenderBox)
        .localToGlobal(const Offset(0.0, 0.0));
    final dragStartY =
        screenSize.height * (Random().nextDouble() < 0.5 ? 0.25 : 0.75) +
            itemTopLeft.dy;
    final dragStartX = screenSize.width / 2 + itemTopLeft.dx;

    return Offset(dragStartX, dragStartY);
  }

  @override
  void dispose() {
    slideBackAnimation.dispose();
    slideOutAnimation.dispose();

    widget.card.removeListener(_slideFromExternal);

    super.dispose();
  }

  void _onPanStart(DragStartDetails details) {
    if (!widget.isDraggable) {
      return;
    }

    dragStartPosition = details.globalPosition;

    if (slideBackAnimation.isAnimating) {
      slideBackAnimation.stop();
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (!widget.isDraggable) {
      return;
    }

    setState(() {
      dragCurrentPosition = details.globalPosition;
      containerOffset = dragCurrentPosition - dragStartPosition;
      if (widget.onSlideUpdate != null) {
        widget.onSlideUpdate(containerOffset.distance);
      }
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (!widget.isDraggable) {
      return;
    }

    final dragVector = containerOffset / containerOffset.distance;
    final isInLeftRegion = (containerOffset.dx / context.size.width) < -0.45;
    final isInRightRegion = (containerOffset.dx / context.size.width) > 0.45;

    setState(() {
      if ((isInLeftRegion || isInRightRegion) && widget.statusComplete) {
        slideOutTween = Tween(
            begin: containerOffset, end: dragVector * (2 * context.size.width));
        slideOutAnimation.forward(from: 0.0);
        slideOutDirection =
            isInLeftRegion ? SlideDirection.Left : SlideDirection.Right;
      } else {
        slideBackStartPosition = containerOffset;
        slideBackAnimation.forward(from: 0.0);
      }
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
              padding:
                  const EdgeInsets.only(top: 0, left: 16, right: 16, bottom: 8),
              child: GestureDetector(
                onPanStart: _onPanStart,
                onPanUpdate: _onPanUpdate,
                onPanEnd: _onPanEnd,
                child: StackedCardViewItemContent(
                  card: widget.card,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
