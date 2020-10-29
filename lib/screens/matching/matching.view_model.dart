import 'package:flutter_to_do/@core/repo/matching/matching.model.dart';
import 'package:flutter_to_do/@core/services/view_state.service.dart';

class MatchingViewModel extends ViewStateModel {

  List<MatchingModel> _listMatching;
  List<MatchingModel> get listMatching => _listMatching;

  String _countMatching = "";
  String get countMatching => _countMatching;


}
