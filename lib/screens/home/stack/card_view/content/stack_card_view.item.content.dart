import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:flutter_to_do/@core/repo/matching/matching.model.dart';
import 'package:flutter_to_do/@shared/utils/utils.dart';
import 'package:flutter_to_do/resources/localization/langs.dart';
import 'package:flutter_to_do/resources/styles/colors.dart';
import 'package:flutter_to_do/resources/styles/styles.dart';

class StackedCardViewItemContent extends StatelessWidget {
  final MatchingModel model;

  StackedCardViewItemContent({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      model != null ? Scaffold(body: getChild(context)) : Container();

  Widget getChild(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [BoxShadow(color: AppColors.lightGray, blurRadius: 4)]),
      width: getWidthPercent(context, 100),
      child: _buildProfile(context),
    );
  }

  Widget _buildProfile(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _itemFlexible(4, _itemProfile(context, model)),
          _lineGray(),
          _itemFlexible(4, _itemList(context, model)),
          _itemFlexible(1, _itemViewMore(context)),
          _lineGray(),
          _itemFlexible(1, _itemAction(context)),
        ],
      ),
    );
  }

  Widget _itemFlexible(int flex, Widget item) =>
      Flexible(flex: flex, fit: FlexFit.tight, child: item);

  Widget _itemProfile(BuildContext context, MatchingModel model) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _itemProfileHeader(context, model),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              model.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style:
                  AppStyles().colorTextDefaultRegular(13).copyWith(height: 1.6),
            ),
          )
        ],
      ),
    );
  }

  Widget _itemProfileHeader(BuildContext context, MatchingModel model) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(45),
            child: Image(
              image: AssetImage(model.avatar),
              fit: BoxFit.cover,
              width: getWidthPercent(context, 22),
              height: getWidthPercent(context, 22),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(child: _itemDetailProfile(context, model)),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.announcement_rounded,
                size: 18,
                color: AppColors.lightGray,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemDetailProfile(BuildContext context, MatchingModel model) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          model.fullName,
          style: AppStyles().colorTextDefaultBold(16),
        ),
        Text(
          model.job,
          style: AppStyles().colorTextDefaultRegular(14),
        ),
        Text(
          model.address,
          style: AppStyles().colorTextDefaultRegular(12),
        ),
        Text(
          model.likeDetail,
          style: AppStyles().colorTextDefaultRegular(14),
        ),
      ],
    );
  }

  Widget _itemList(BuildContext context, MatchingModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(getString(context, AppLangs.text_text_interests),
            style: AppStyles().colorTextDefaultBold(13)),
        _itemListInterests(model.skills),
        Text(getString(context, AppLangs.text_text_skills),
            style: AppStyles().colorTextDefaultBold(13)),
        _itemListInterests(model.interests)
      ],
    );
  }

  Widget _itemListInterests(List<String> list) {
    return Tags(
      itemCount: list.length,
      itemBuilder: (int index) {
        return ItemTags(
          index: index,
          textColor: AppColors.lightOrange,
          pressEnabled: false,
          active: false,
          textStyle: AppStyles().lightOrangeRegular(12),
          textOverflow: TextOverflow.ellipsis,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(width: 1.5, color: AppColors.lightOrange),
          elevation: 0,
          title: list[index],
        );
      },
    );
  }

  Widget _itemSkillDetail(String content) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(width: 1, color: AppColors.lightOrange)),
      child: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Text(content),
      )),
    );
  }

  Widget _itemViewMore(BuildContext context) {
    return Center(
        child: Text(
      getString(context, AppLangs.text_view_more),
      style: AppStyles().darkBrownRegular(17),
    ));
  }

  Widget _itemAction(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          getString(context, AppLangs.text_text_remove),
          style: AppStyles().whiteRegular(14),
        ),
        Divider(
          thickness: 1,
          color: AppColors.lightGray,
        ),
        Text(
          getString(context, AppLangs.text_text_accept),
          style: AppStyles().whiteRegular(14),
        ),
      ],
    );
  }

  Widget _lineGray() => Container(
        color: AppColors.lightGray,
        width: double.infinity,
        height: 1,
      );
}
