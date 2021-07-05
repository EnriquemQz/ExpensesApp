
import 'package:flutter/cupertino.dart';


class UiProvider extends ChangeNotifier {

  int _selectedMenu = 0;
  int _selectedMonth = DateTime.now().month - 1;

  int get selectedMenu {
    return this._selectedMenu;
  }

  set selectedMenu(int i){
    this._selectedMenu = i;
    notifyListeners();
  }

  int get selectedMonth {
    return this._selectedMonth;
  }

  set selectedMonth(int i){
    this._selectedMonth = i;
    notifyListeners();
  }

}