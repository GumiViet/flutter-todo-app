import 'package:flutter_to_do/@core/services/view_state.service.dart';

class HomeViewModel extends ViewStateModel{

  int _indexTab = 0;
  int get indexTab=>_indexTab;
  set indexTab(val){
    _indexTab = val;
    notifyListeners();
  }

}