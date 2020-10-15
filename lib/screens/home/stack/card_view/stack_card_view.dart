import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_do/@core/dependency_injection.dart';
import 'package:flutter_to_do/@core/enums.dart';
import 'package:flutter_to_do/@core/services/log.service.dart';
import 'package:flutter_to_do/resources/styles/images.dart';
import 'package:flutter_to_do/screens/base_screen.dart';
import 'package:flutter_to_do/screens/home/stack/card_set/stack_card_set.dart';
import 'package:flutter_to_do/screens/home/stack/card_view/stack_card_view.view_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'item/stack_card_view.item.dart';

class StackedCardView extends StatefulWidget {
  final StackedCardSet cardSet;

  StackedCardView({@required this.cardSet});

  @override
  _StackedCardViewState createState() => _StackedCardViewState();
}

class _StackedCardViewState extends BaseScreen<StackedCardView> {
  StackCardViewViewModel viewModel = byInject<StackCardViewViewModel>();
  Key _frontItemKey;

  @override
  void initState() {
    super.initState();
    _setItemKey();
  }

  @override
  Widget build(BuildContext context) {
    var defaultSizeSwipe = getWidthWithPercent(15);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<StackCardViewViewModel>(
        builder: (context, viewModel, child) {
          return Container(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                _buttonAccept(
                    viewModel.distance, viewModel.draggable, defaultSizeSwipe),
                Expanded(
                  child: _imageCenter(viewModel.distance, viewModel.draggable,
                      defaultSizeSwipe),
                ),
                _buttonRemove(
                    viewModel.distance, viewModel.draggable, defaultSizeSwipe),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _imageCenter(
      double distance, double draggable, double defaultSizeSwipe) {
    return Transform.translate(
      offset: Offset(
          distance == 0
              ? 0
              : draggable > 0
                  ? (distance - 0.8) * 5 * defaultSizeSwipe
                  : -((distance - 0.8) * 5 * defaultSizeSwipe),
          0),
      child: Stack(
        children: <Widget>[
          _buildBackItem(distance),
          _buildFrontItem(),
        ],
      ),
    );
  }

  Widget _buttonAccept(
      double distance, double draggable, double defaultSizeSwipe) {
    return Transform.translate(
      offset: Offset(
          draggable > 0
              ? ((distance - 0.8) * 5 * defaultSizeSwipe) - defaultSizeSwipe
              : -defaultSizeSwipe,
          50),
      child: GestureDetector(
        onTap: () {
          setState(() {
            widget.cardSet.incrementCardIndex();
            _setItemKey();
            viewModel.clearSlide();
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image(
              image: AssetImage(AppImages.icAccept),
              height:
                  draggable > 0 ? (distance - 0.8) * 5 * defaultSizeSwipe : 0),
        ),
      ),
    );
  }

  Widget _buttonRemove(
      double distance, double draggable, double defaultSizeSwipe) {
    return Transform.translate(
      offset: Offset(
          draggable < 0
              ? defaultSizeSwipe - ((distance - 0.8) * 5 * defaultSizeSwipe)
              : defaultSizeSwipe,
          50),
      child: GestureDetector(
        onTap: () {
          setState(() {
            widget.cardSet.incrementCardIndex();
            _setItemKey();
            viewModel.clearSlide();
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image(
              image: AssetImage(AppImages.icRemove),
              height:
                  draggable < 0 ? (distance - 0.8) * 5 * defaultSizeSwipe : 0),
        ),
      ),
    );
  }

  void _setItemKey() {
    _frontItemKey = Key(widget.cardSet.getKey());
  }

  void _onSlideUpdate(double distance, double draggable) {
    viewModel.setDistanceAndDraggable(distance, draggable);
  }

  void _onSlideComplete(SlideDirection direction) {
    // switch (direction) {
    //   case SlideDirection.Left:
    //     break;
    //   case SlideDirection.Right:
    //     break;
    //   case SlideDirection.Up:
    //     // TODO: Handle this case.
    //     break;
    // }
    // viewModel.setDistanceAndDraggable(0.0, 0.0);
    // setState(() {
    //   widget.cardSet.incrementCardIndex();
    //   _setItemKey();
    // });
  }

  Widget _buildBackItem(double distance) {
    return StackedCardViewItem(
        isDraggable: true, card: widget.cardSet.getNextCard(), scale: distance);
  }

  Widget _buildFrontItem() {
    return StackedCardViewItem(
      key: _frontItemKey,
      onSlideUpdate: _onSlideUpdate,
      statusComplete:
          widget.cardSet.currentCardIndex < widget.cardSet.cards.length,
      onSlideComplete: _onSlideComplete,
      card: widget.cardSet.getFirstCard(),
    );
  }
}
