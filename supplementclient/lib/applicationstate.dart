import 'package:flutter/material.dart';
import 'package:supplementclient/model.dart';

class ApplicationState with ChangeNotifier {
  var i = 0;
  String? apiKey;
  var selectedPage = 0;
  List<Uom?>? uoms = [];

  setUoms(List<Uom?>? u_) {
    uoms = u_;
    notifyListeners();
  }

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
