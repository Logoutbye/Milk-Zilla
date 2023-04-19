import 'package:flutter/foundation.dart';



class SelectedItemProvider with ChangeNotifier {
  int _selectedItem = 0;
  int get selectedItem => _selectedItem;

  void incrementSelectedItem() {
    _selectedItem++;
    notifyListeners();
  }

  void decrementSelectedItem() {
    _selectedItem--;
    notifyListeners();
  }
}