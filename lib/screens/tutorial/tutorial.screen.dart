import 'package:flutter/material.dart';
import 'package:flutter_to_do/resources/localization/langs.dart';
import 'package:flutter_to_do/resources/styles/colors.dart';
import 'package:flutter_to_do/resources/styles/fonts.dart';
import 'package:flutter_to_do/screens/base_screen.dart';

class TutorialScreen extends StatefulWidget {
  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends BaseScreen<TutorialScreen> {
  @override
  Widget build(BuildContext context) {
    return baseScaffold(
        myBody: Column(
          children: [
            _itemBottom()
          ],
      // children: _itemTop().add(_itemBottom())
      // [
      //   Flexible(child: _itemTop()),
      //   _itemBottom(),
      // ],
    ));
  }

  List<Widget> _itemTop() => [
        IconButton(
            icon: Icon(Icons.arrow_forward_ios_sharp),
            onPressed: () => print("next steps")),
        Text(getStringById(AppLangs.text_app_name)),
        Text(getStringById(AppLangs.text_app_name)),
      ];

  Widget _itemBottom() => Container(
        color: AppColors.white,
        height: getHeightWithPercent(10),
      );
}
