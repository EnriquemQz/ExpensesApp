import 'package:expenses_app/models/expenses_model.dart';

RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
Function mathFunc = (Match match) => '${match[1]},';

getBalance(List<ExpensesModel> expenses, var entries){
  double _expenses;
  // double _entries;
  double _balance;

  _expenses = expenses.map((e) => e.expense).fold(0.0, (a, b) => a + b);

  _balance = entries - _expenses;
  return _balance.toStringAsFixed(2).replaceAllMapped(reg, mathFunc);
}

getSumOfExpenses(List<ExpensesModel> expenses){
  double _expenses;

  _expenses = expenses.map((e) => e.expense).fold(0.0, (a, b) => a + b);
  return _expenses.toStringAsFixed(2).replaceAllMapped(reg, mathFunc);
}