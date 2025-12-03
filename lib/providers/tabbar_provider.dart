import 'package:flutter/material.dart';

class TabbarProvider extends ChangeNotifier{
  int _selectedMEnuOption =0;

  int get selectedMEnuOption{
    return _selectedMEnuOption;
  }

  set selectedMEnuOption(int i){

    if (_selectedMEnuOption == i) return;
    _selectedMEnuOption = i;
    notifyListeners();
  }
}
