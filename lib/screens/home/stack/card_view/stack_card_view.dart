import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_do/@core/dependency_injection.dart';
import 'package:flutter_to_do/@core/enums.dart';
import 'package:flutter_to_do/resources/styles/images.dart';
import 'package:flutter_to_do/screens/base_screen.dart';
import 'package:flutter_to_do/screens/home/stack/card_set/stack_card_set.dart';
import 'package:flutter_to_do/screens/home/stack/card_view/item/stack_card_view.view_model.dart';
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
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<StackCardViewViewModel>(
        builder: (context, viewModel, child) {
          return Row(
            children: [
              Transform.translate(
                offset: Offset(
                    viewModel.draggable > 0
                        ? ((viewModel.distance - 0.8) * 5 * 60) - 60
                        : -60,
                    50),
                child:
                    // Image(image: AssetImage(AppImages.icAccept), height: 55),
                    Image(
                        image: AssetImage(AppImages.icAccept),
                        height: viewModel.draggable > 0
                            ? (viewModel.distance - 0.8) * 5 * 45
                            : 0),
              ),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    _buildBackItem(viewModel.distance),
                    _buildFrontItem(),
                  ],
                ),
              ),
              Transform.translate(
                offset: Offset(
                    viewModel.draggable < 0
                        ? 60 - ((viewModel.distance - 0.8) * 5 * 60)
                        : 60,
                    50),
                child:
                    // Image(image: AssetImage(AppImages.icRemove), height: 55),
                    Image(
                        image: AssetImage(AppImages.icRemove),
                        height: viewModel.draggable < 0
                            ? (viewModel.distance - 0.8) * 5 * 45
                            : 0),
              ),
            ],
          );
          // return Row(
          //   children: [
          //     Transform.translate(
          //       offset: Offset(
          //           viewModel.draggable > 0
          //               ? -60 + ((viewModel.distance - 0.8) * 5 * 60)
          //               : -60,
          //           50),
          //       child: Image(image: AssetImage(AppImages.icAccept), height: 45),
          //     ),
          //     Expanded(
          //       child: Stack(
          //         children: <Widget>[
          //           _buildBackItem(viewModel.distance),
          //           _buildFrontItem(),
          //         ],
          //       ),
          //     ),
          //     Transform.translate(
          //       offset: Offset(
          //           viewModel.draggable < 0
          //               ? 60 - ((viewModel.distance - 0.8) * 5 * 60)
          //               : 60,
          //           50),
          //       child: Image(image: AssetImage(AppImages.icRemove), height: 45),
          //     ),
          //   ],
          // );
        },
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
    switch (direction) {
      case SlideDirection.Left:
        Fluttertoast.showToast(msg: "Swipe remove");
        break;
      case SlideDirection.Right:
        Fluttertoast.showToast(msg: "Swipe accept");
        break;
      case SlideDirection.Up:
        // TODO: Handle this case.
        break;
    }
    viewModel.setDistanceAndDraggable(0.0, 0.0);
    setState(() {
      widget.cardSet.incrementCardIndex();
      _setItemKey();
    });
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
