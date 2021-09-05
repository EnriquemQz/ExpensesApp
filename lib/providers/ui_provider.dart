
import 'package:flutter/cupertino.dart';


class UiProvider extends ChangeNotifier {

  int _selectedMenu = 0;
  int _selectedMonth = DateTime.now().month - 1;
  String _selectedChart = 'Gráfico Lineal';

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

  String get selectedChart {
    return this._selectedChart;
  }

  set selectedChart(String i){
    this._selectedChart = i;
    notifyListeners();
  }
}