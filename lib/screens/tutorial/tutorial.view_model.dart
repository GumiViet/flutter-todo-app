import 'package:flutter_to_do/@core/repo/tutorial/tutorial.model.dart';
import 'package:flutter_to_do/@core/services/view_state.service.dart';

class TutorialViewModel extends ViewStateModel {

  List<TutorialModel> _listTutorial = [];
  List<TutorialModel> get listTutorial => _listTutorial;
  set listTutorial(val){
    _listTutorial = val;
    notifyListeners();
  }

  double _currentPage = 0;
  double get currentPage => _currentPage;
  set currentPage(val){
    _currentPage = val;
    notifyListeners();
  }

}
