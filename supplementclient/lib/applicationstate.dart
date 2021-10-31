import 'package:flutter/material.dart';

class ApplicationState with ChangeNotifier {
  var i = 0;

  setI(int i_) {
    i = i_;
    notifyListeners();
  }
}
