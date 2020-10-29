import 'package:flutter/material.dart';
import 'package:flutter_to_do/@core/repo/matching/matching.model.dart';
import 'package:flutter_to_do/resources/styles/colors.dart';
import 'package:flutter_to_do/resources/styles/images.dart';
import 'package:flutter_to_do/resources/styles/styles.dart';
import 'package:flutter_to_do/screens/base_screen.dart';
import 'package:flutter_to_do/screens/home/stack/card_set/stack_card_set.dart';
import 'package:flutter_to_do/screens/home/stack/card_view/stack_card_view.dart';

class MatchingScreen extends StatefulWidget {

  @override
  _MatchingScreenState createState() => _MatchingScreenState();
}

class _MatchingScreenState extends BaseScreen<MatchingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidthWithPercent(100),
      child: Column(
        children: [
          _itemCountMatching("1/${cardSet.cards.length}"),
          SizedBox(
            height: 8,
          ),
          Expanded(child: _itemMatching())
        ],
      ),
    );
  }

  Widget _itemCountMatching(String count) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [BoxShadow(color: AppColors.lightGray, blurRadius: 8)]),
        child: Column(
          children: [
            lineVertical(1),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                count,
                style: AppStyles().blackRegular(15),
              ),
            )),
          ],
        ));
  }

  Widget _itemMatching() {
    return StackedCardView(
      cardSet: cardSet,
    );
  }

  var cardSet = StackedCardSet(cards: [
    MatchingModel(
        avatar: AppImages.imgDemo_1,
        fullName: "田中 太郎",
        job: "経営者 / CEO / 株式会社",
        address: "渋谷・東京都",
        likeDetail: "109人が好印象",
        description:
            "私は現在株式会社で代表取締役社長CEOとして社員130人と共に日々事業を拡大し社員と楽しく仕事をしております。元々はサーバーサイドのエンジニアとして株式会社で",
        interests: ["ベンチャー", "経営", "Pyhon"],
        skills: ["マネージメント", "営業", "新規開拓営業", "サーバーサイドエンジニア", "AI開発"]),
    MatchingModel(
        avatar: AppImages.imgDemo_2,
        fullName: "田中 太郎",
        job: "経営者 / CEO / 株式会社",
        address: "渋谷・東京都",
        likeDetail: "109人が好印象",
        description:
            "私は現在株式会社で代表取締役社長CEOとして社員130人と共に日々事業を拡大し社員と楽しく仕事をしております。元々はサーバーサイドのエンジニアとして株式会社で",
        interests: ["ベンチャー", "経営", "Pyhon"],
        skills: ["マネージメント", "営業", "新規開拓営業", "サーバーサイドエンジニア", "AI開発"]),
    MatchingModel(
        avatar: AppImages.imgDemo_3,
        fullName: "田中 太郎",
        job: "経営者 / CEO / 株式会社",
        address: "渋谷・東京都",
        likeDetail: "109人が好印象",
        description:
            "私は現在株式会社で代表取締役社長CEOとして社員130人と共に日々事業を拡大し社員と楽しく仕事をしております。元々はサーバーサイドのエンジニアとして株式会社で",
        interests: ["ベンチャー", "経営", "Pyhon"],
        skills: ["マネージメント", "営業", "新規開拓営業", "サーバーサイドエンジニア", "AI開発"]),
  ]);
}
