import 'package:flutter/material.dart';

class BottomBarIndexProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex{
    return _currentIndex;
  }
  void setCurrentIndex(int value){
    _currentIndex = value;
    notifyListeners();
  }
}