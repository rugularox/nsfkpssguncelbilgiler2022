import 'package:flutter/cupertino.dart';

class StateData with ChangeNotifier {
  String secilentab = 'tum';

  void yenitab(String yenitab) {
    secilentab = yenitab;
    notifyListeners();
  }
}
