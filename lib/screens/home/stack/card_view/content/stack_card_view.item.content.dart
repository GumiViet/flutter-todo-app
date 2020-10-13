import 'package:flutter/material.dart';
import 'package:flutter_to_do/resources/styles/colors.dart';
import 'package:flutter_to_do/screens/home/stack/card/stack_card.dart';
import 'package:flutter_to_do/screens/home/stack/photo/photo.view.dart';

class StackedCardViewItemContent extends StatelessWidget {
  final StackedCard card;

  StackedCardViewItemContent({
    Key key,
    this.card,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return card != null ? Scaffold(body: getChild(context)) : Container();
  }

  Widget getChild(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5.0,
              spreadRadius: 2.0,
            )
          ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Material(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              _buildBackground(),
              _buildProfile(),
            ],
          ),
        ),
      ),
    );
    // return SingleChildScrollView(
    //   child: Container(
    //     height: MediaQuery.of(context).size.height,
    //     decoration: BoxDecoration(color: AppColors.black, boxShadow: [
    //       BoxShadow(
    //         color: Colors.black12,
    //         blurRadius: 5.0,
    //         spreadRadius: 2.0,
    //       )
    //     ]),
    //     child: Stack(
    //       children: [
    //         ClipRRect(
    //           borderRadius: BorderRadius.circular(10.0),
    //           child: _buildBackground(),
    //         ),
    //         Align(alignment: Alignment.bottomRight, child: Padding(
    //           padding: const EdgeInsets.only(bottom: 50),
    //           child: _buildProfile(),
    //         ),),
    //       ],
    //     ),
        // child: Column(
        //   children: [
        //     SizedBox(
        //       height: MediaQuery.of(context).size.height * 0.4,
        //       child: ClipRRect(
        //         borderRadius: BorderRadius.circular(10.0),
        //         child: _buildBackground(),
        //       ),
        //     ),
        //     _buildProfile(),
        //   ],
        // ),
    //   ),
    // );
  }

  Widget _buildBackground() {
    return PhotoView(
      photoAssetPaths: card.photos,
      visiblePhotoIndex: 0,
    );
  }

  Widget _buildProfile() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(card.title,
                    style: TextStyle(color: Colors.white, fontSize: 24.0)),
                Text(card.subTitle,
                    style: TextStyle(color: Colors.white, fontSize: 18.0))
              ],
            ),
          ),
          Icon(
            Icons.info,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
