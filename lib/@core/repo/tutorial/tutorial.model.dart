import 'package:flutter_to_do/@core/repo/base.model.dart';

class TutorialModel extends BaseModel {
  String title;
  String description;
  String image;

  TutorialModel({
    this.title,
    this.description,
    this.image,
  });

  @override
  fromJson(json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }
}
