import 'package:flutter/material.dart';

class ApplicationState with ChangeNotifier {
  var i = 0;
  String? apiKey;
  var selectedPage = 0;

  setI(int i_) {
    i = i_;
    notifyListeners();
  }

  setApiKey(String? a) {
    apiKey = a;
    notifyListeners();
  }

  setSelectedPage(int s) {
    selectedPage = s;
    notifyListeners();
  }
}
