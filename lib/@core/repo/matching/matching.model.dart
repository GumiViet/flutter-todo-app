import 'package:flutter_to_do/@core/repo/base.model.dart';

class MatchingModel extends BaseModel{

  String avatar;
  String fullName;
  String job;
  String address;
  String likeDetail;
  String description;
  List<String> interests;
  List<String> skills;

  MatchingModel({
    this.avatar,
    this.fullName,
    this.job,
    this.address,
    this.likeDetail,
    this.description,
    this.interests,
    this.skills,
  });

  @override
  fromJson(json) {
    throw UnimplementedError();
  }
}