import 'package:flutter/material.dart';
import 'package:flutter_to_do/@core/dependency_injection.dart';
import 'package:flutter_to_do/@shared/utils/utils.dart';
import 'package:flutter_to_do/resources/localization/langs.dart';
import 'package:flutter_to_do/resources/styles/colors.dart';
import 'package:flutter_to_do/resources/styles/images.dart';
import 'package:flutter_to_do/resources/styles/styles.dart';
import 'package:flutter_to_do/screens/base_screen.dart';
import 'package:flutter_to_do/screens/home/home.view_model.dart';
import 'package:flutter_to_do/screens/home/stack/card/stack_card.dart';
import 'package:flutter_to_do/screens/home/stack/card_view/stack_card_view.dart';
import 'package:flutter_to_do/screens/matching/matching.screen.dart';
import 'package:flutter_to_do/screens/message/message.screen.dart';
import 'package:provider/provider.dart';

import 'stack/card_set/stack_card_set.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseScreen<HomeScreen> {
  var viewModel = byInject<HomeViewModel>();
  var controller = PageController(viewportFraction: 1);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: _itemAppBar(viewModel.indexTab),
            body: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onPanDown: (_) => FocusScope.of(context).unfocus(),
              onTap: () => FocusScope.of(context).unfocus(),
              child: SafeArea(
                  child: Column(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: _itemBody(),
                  )),
                ],
              )),
            ),
            bottomNavigationBar: _itemBottomBar(viewModel.indexTab),
            resizeToAvoidBottomInset: false,
            resizeToAvoidBottomPadding: false,
          );
        },
      ),
    );
  }

  Widget _itemAppBar(int indexTab) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      title: Text(
        getStringById(indexTab == 0
            ? AppLangs.text_title_matching
            : AppLangs.text_title_message),
        style: AppStyles().colorTextDefaultBold(17),
      ),
    );
  }

  Widget _itemBody() {
    return PageView(
      controller: controller,
      physics: NeverScrollableScrollPhysics(),
      children: [
        MatchingScreen(),
        MessageScreen(),
      ],
    );
  }

  BottomNavigationBar _itemBottomBar(int index) => BottomNavigationBar(
        currentIndex: index,
        backgroundColor: AppColors.white,
        elevation: 0,
        onTap: (tab) {
          controller.jumpToPage(tab);
          // controller.animateToPage(tab,
          //     duration: Duration(milliseconds: 0), curve: Curves.easeInOut);
          viewModel.indexTab = tab;
        },
        iconSize: 32,
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: AppColors.lightGray,
        selectedFontSize: 12,
        unselectedFontSize: 10,
        items: [
          _itemBottomNavigation(
              Icons.person_add_alt_1, "10", AppLangs.text_title_matching),
          _itemBottomNavigation(
              Icons.messenger, "4", AppLangs.text_title_message),
        ],
      );

  BottomNavigationBarItem _itemBottomNavigation(
          IconData icon, String count, String label) =>
      BottomNavigationBarItem(
          icon: Stack(children: <Widget>[
            Icon(icon),
            Positioned(
                top: 0.0,
                right: 0.0,
                child: Container(
                  width: getWidthWithPercent(5),
                  height: getWidthWithPercent(5),
                  decoration: BoxDecoration(
                      color: AppColors.darkRed,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Text(count, style: AppStyles().whiteRegular(10))),
                ))
          ]),
          label: getStringById(label));
}
