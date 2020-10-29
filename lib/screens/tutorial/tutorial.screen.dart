import 'package:flutter/material.dart';
import 'package:flutter_to_do/@core/constants.dart';
import 'package:flutter_to_do/@core/dependency_injection.dart';
import 'package:flutter_to_do/@core/repo/tutorial/tutorial.model.dart';
import 'package:flutter_to_do/@shared/utils/utils.dart';
import 'package:flutter_to_do/resources/localization/langs.dart';
import 'package:flutter_to_do/resources/styles/colors.dart';
import 'package:flutter_to_do/resources/styles/images.dart';
import 'package:flutter_to_do/resources/styles/styles.dart';
import 'package:flutter_to_do/screens/base_screen.dart';
import 'package:provider/provider.dart';
import 'package:route_annotation/route_annotation.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'tutorial.view_model.dart';

@page
class TutorialScreen extends StatefulWidget {
  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends BaseScreen<TutorialScreen> {
  TutorialViewModel viewModel = byInject<TutorialViewModel>();
  PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(viewportFraction: 1);
    viewModel.listTutorial = _listTutorialDemo();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<TutorialViewModel>(
        builder: (context, viewModel, child) {
          return baseScaffold(
              myBody: Container(
            color: AppColors.lightGray,
            child: Column(
              children: [
                _itemTop(viewModel.listTutorial, controller),
                _itemBottom(
                    viewModel.listTutorial, controller, viewModel.currentPage),
              ],
            ),
          ));
        },
      ),
    );
  }

  Widget _itemTop(List<TutorialModel> list, PageController controller) {
    return Expanded(
        child: PageView(
      controller: controller,
      onPageChanged: (page) {
        viewModel.currentPage = page.toDouble();
      },
      children: List.generate(list.length, (index) {
        return index == 0
            ? _itemPageNoImage(list[index])
            : _itemPageImage(list[index]);
      }),
    ));
  }

  Widget _itemPageNoImage(TutorialModel model) {
    return Column(
      children: [
        Flexible(
          flex: 7,
          child: Center(
              child: Text(
            model.title,
            style: AppStyles().blackRegular(80),
          )),
        ),
        Flexible(
            flex: 5,
            child: Center(
              child: Text(
                model.description,
                textAlign: TextAlign.center,
                style: AppStyles().whiteRegular(16),
              ),
            ))
      ],
    );
  }

  Widget _itemPageImage(TutorialModel model) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
            flex: 1,
            child: Center(
              heightFactor: 0.2,
              child: Text(
                model.title,
                style: AppStyles().whiteRegular(20),
              ),
            )),
        Flexible(
            flex: 4,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  model.description,
                  textAlign: TextAlign.center,
                  style: AppStyles().whiteRegular(14),
                ),
              ),
            )),
        Flexible(flex: 7, child: Image(image: AssetImage(model.image))),
      ],
    );
  }

  Widget _itemBottom(List<TutorialModel> list, PageController controller,
          double currentPage) =>
      Container(
        color: AppColors.white,
        height: getHeightWithPercent(10),
        width: getWidthWithPercent(100),
        child: Stack(
          children: [
            Visibility(
              visible: currentPage != list.length - 1,
              child: Center(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: list.length,
                  effect: ScrollingDotsEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 16,
                    activeDotColor: AppColors.mediumGray,
                    dotColor: AppColors.lightGray,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: currentPage != list.length - 1,
              child: SizedBox(
                height: getHeightWithPercent(10),
                width: getWidthWithPercent(25),
                child: Center(
                  child: GestureDetector(
                    onTap: () => controller.animateToPage(list.length - 1,
                        duration: Duration(milliseconds: 1000),
                        curve: Curves.easeInOut),
                    child: Container(
                      height: getHeightWithPercent(5),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(color: AppColors.mediumGray, blurRadius: 4)
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(getStringById(AppLangs.text_title_skip),
                            style: AppStyles().lightGrayRegular(10)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
                visible: currentPage == list.length - 1,
                child: Center(
                    child: GestureDetector(
                  onTap: () =>
                      goToAndRemoveScreen(context, AppConstants.ROUTE_HOME_SCREEN),
                  child: Text(
                    getStringById(AppLangs.text_start),
                    style: AppStyles().darkBrownRegular(20),
                  ),
                ))),
          ],
        ),
      );

  List<TutorialModel> _listTutorialDemo() => [
        TutorialModel(
            title: "BizOn!",
            description:
                "お互いのビジネス(Business)を\n\n理解し合い重ね合わせる(On)ことで\n\n両者のビジネスが発展・前進\n\nすることを実現するアプリ",
            image: ""),
        TutorialModel(
            title: "STEP 1",
            description: "経歴やスキル、興味関心などのプロフィール\n情報を記入して審査通過の連絡を待ちましょう",
            image: AppImages.imgTutorial_1),
        TutorialModel(
            title: "STEP 2",
            description: "レコメンドされるユーザーを左右にスワイプ して\n『興味あり』『興味なし』に振り分けましょう",
            image: AppImages.imgTutorial_2),
        TutorialModel(
            title: "STEP 3",
            description: "お互いに『興味あり』の場合、マッチングします",
            image: AppImages.imgTutorial_3),
        TutorialModel(
            title: "STEP 4",
            description: "マッチングしたユーザー同士でメッセージが\n可能になります。",
            image: AppImages.imgTutorial_4),
      ];
}
